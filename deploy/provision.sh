#!/usr/bin/env bash
# =============================================================================
# deploy/provision.sh - stand up theVault CE as a Tor onion service.
#
# Supports RPM-based (Rocky/Alma/RHEL/Fedora) and Debian/Ubuntu hosts.
# Idempotent: safe to re-run. Run as root on a fresh server:
#
#   curl -fsSL <raw URL of this file> -o provision.sh && sudo bash provision.sh
#
# Design notes
#   * The web stack listens on 127.0.0.1:8080 only. An onion service makes
#     outbound connections to the Tor network, so NO inbound web port is opened.
#   * Search uses Scout's "database" driver (no Elasticsearch) to fit 2 GB RAM.
#   * The hosting provider can still see that this machine makes encrypted
#     connections to Tor relays. To disguise that, supply obfs4 bridge lines
#     (BRIDGE_LINES) - see below. Content and the .onion address stay hidden.
#   * Nginx access logging is off.
#
# Environment variables (all optional)
#   REPO_URL         Git repo to deploy   (default: public GitHub repo)
#   REPO_REF         Branch/tag to deploy (default: main)
#   APP_DIR          Install path         (default: /var/www/thevault)
#   DB_NAME/DB_USER  MariaDB names        (default: marketplace / thevault)
#   DB_PASS          MariaDB password     (default: random, saved to CREDS_FILE)
#   CREDS_FILE       Where secrets go     (default: /root/.thevault-credentials)
#   IMPORT_DEMO      yes|no - import example_files/marketplace_backup.sql
#                    (default: yes; "no" runs php artisan migrate instead)
#   HS_KEY_DIR       Directory holding a BACKED-UP onion key (hostname,
#                    hs_ed25519_public_key, hs_ed25519_secret_key) to keep the
#                    old .onion address. Default: generate a new address.
#   BRIDGE_LINES     Newline-separated obfs4 bridge lines (e.g. from the Tor
#                    Project bridge request page). Enables UseBridges.
#   NGINX_PORT       Local listen port    (default: 8080)
# =============================================================================
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/hack-r/theVault-Darknet-Market.git}"
REPO_REF="${REPO_REF:-main}"
APP_DIR="${APP_DIR:-/var/www/thevault}"
SRC_DIR="${SRC_DIR:-/opt/thevault-src}"
DB_NAME="${DB_NAME:-marketplace}"
DB_USER="${DB_USER:-thevault}"
CREDS_FILE="${CREDS_FILE:-/root/.thevault-credentials}"
IMPORT_DEMO="${IMPORT_DEMO:-yes}"
HS_KEY_DIR="${HS_KEY_DIR:-}"
BRIDGE_LINES="${BRIDGE_LINES:-}"
NGINX_PORT="${NGINX_PORT:-8080}"
HS_DIR="/var/lib/tor/thevault"
CE_SUBDIR="app/theVault_community_edition"

log()  { printf '\n\033[1;32m[thevault]\033[0m %s\n' "$*"; }
warn() { printf '\n\033[1;33m[thevault] WARNING:\033[0m %s\n' "$*" >&2; }
die()  { printf '\n\033[1;31m[thevault] ERROR:\033[0m %s\n' "$*" >&2; exit 1; }

[[ $EUID -eq 0 ]] || die "Run as root."

# --- distro detection --------------------------------------------------------
if command -v dnf >/dev/null 2>&1; then
  PM=dnf
elif command -v apt-get >/dev/null 2>&1; then
  PM=apt
else
  die "Unsupported distro: need dnf or apt-get."
fi
log "Package manager: $PM"

# --- secrets -----------------------------------------------------------------
if [[ -f "$CREDS_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$CREDS_FILE"
fi
DB_PASS="${DB_PASS:-$(head -c 24 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 24)}"
umask 077
cat > "$CREDS_FILE" <<CREDS
DB_PASS='${DB_PASS}'
CREDS
chmod 600 "$CREDS_FILE"
umask 022

# --- packages ----------------------------------------------------------------
log "Installing packages..."
if [[ $PM == dnf ]]; then
  dnf install -y epel-release || true
  # Composer needs PHP >= 8.2; try newer AppStream module streams first.
  dnf module reset -y php >/dev/null 2>&1 || true
  dnf module enable -y php:8.3 >/dev/null 2>&1 || dnf module enable -y php:8.2 >/dev/null 2>&1 || true
  dnf install -y nginx mariadb-server tor git rsync unzip curl policycoreutils \
    php php-cli php-fpm php-mysqlnd php-mbstring php-xml php-gd php-curl php-zip \
    php-intl php-bcmath php-gmp php-opcache
  WEB_USER=nginx
  FPM_SERVICE=php-fpm
  MARIADB_SERVICE=mariadb
  TOR_SERVICE=tor
  FPM_SOCK=/run/php-fpm/www.sock
  FPM_POOL=/etc/php-fpm.d/www.conf
  NGINX_CONF=/etc/nginx/conf.d/thevault.conf
else
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y
  apt-get install -y nginx mariadb-server tor git rsync unzip curl \
    php-cli php-fpm php-mysql php-mbstring php-xml php-gd php-curl php-zip \
    php-intl php-bcmath php-gmp
  PHPV="$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')"
  WEB_USER=www-data
  FPM_SERVICE="php${PHPV}-fpm"
  MARIADB_SERVICE=mariadb
  TOR_SERVICE=tor
  FPM_SOCK="/run/php/php${PHPV}-fpm.sock"
  FPM_POOL="/etc/php/${PHPV}/fpm/pool.d/www.conf"
  NGINX_CONF=/etc/nginx/conf.d/thevault.conf
  rm -f /etc/nginx/sites-enabled/default
fi

command -v composer >/dev/null 2>&1 || {
  log "Installing Composer..."
  curl -fsSL https://getcomposer.org/installer -o /tmp/composer-setup.php
  php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
  rm -f /tmp/composer-setup.php
}

PHP_OK="$(php -r 'echo version_compare(PHP_VERSION, "8.2.0", ">=") ? "yes" : "no";')"
[[ "$PHP_OK" == yes ]] || die "PHP $(php -r 'echo PHP_VERSION;') is too old (need >= 8.2). Enable a newer PHP stream or repo (e.g. Remi on RPM hosts) and re-run."
log "PHP $(php -r 'echo PHP_VERSION;') OK"

# --- fetch the app -----------------------------------------------------------
log "Fetching $REPO_URL ($REPO_REF)..."
if [[ -d "$SRC_DIR/.git" ]]; then
  git -C "$SRC_DIR" fetch --depth 1 origin "$REPO_REF"
  git -C "$SRC_DIR" checkout -q FETCH_HEAD
else
  git clone --depth 1 --branch "$REPO_REF" "$REPO_URL" "$SRC_DIR"
fi
[[ -d "$SRC_DIR/$CE_SUBDIR" ]] || die "$CE_SUBDIR not found in the repo."

mkdir -p "$APP_DIR"
# Keep the generated .env and uploaded storage across re-runs.
rsync -a --delete \
  --exclude '/.env' --exclude '/storage/app' --exclude '/storage/logs' \
  "$SRC_DIR/$CE_SUBDIR/" "$APP_DIR/"
if [[ ! -f "$APP_DIR/vendor/autoload.php" ]]; then
  log "vendor/ missing - running composer install..."
  (cd "$APP_DIR" && COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --no-interaction --optimize-autoloader)
fi
mkdir -p "$APP_DIR/storage/framework/"{cache,sessions,views} "$APP_DIR/storage/logs" "$APP_DIR/bootstrap/cache"

# --- database ----------------------------------------------------------------
log "Configuring MariaDB..."
systemctl enable --now "$MARIADB_SERVICE"
mysql -u root <<SQL
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
ALTER USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
SQL

# --- .env --------------------------------------------------------------------
if [[ ! -f "$APP_DIR/.env" ]]; then
  cp "$APP_DIR/.env.example" "$APP_DIR/.env"
fi
setenv() { # setenv KEY VALUE
  if grep -qE "^$1=" "$APP_DIR/.env"; then
    sed -i "s|^$1=.*|$1=$2|" "$APP_DIR/.env"
  else
    echo "$1=$2" >> "$APP_DIR/.env"
  fi
}
setenv DB_DATABASE "$DB_NAME"
setenv DB_USERNAME "$DB_USER"
setenv DB_PASSWORD "$DB_PASS"
setenv SCOUT_DRIVER database
grep -qE '^APP_KEY=base64:' "$APP_DIR/.env" || (cd "$APP_DIR" && php artisan key:generate --force)

TABLE_COUNT="$(mysql -u root -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';")"
if [[ "$TABLE_COUNT" -eq 0 ]]; then
  if [[ "$IMPORT_DEMO" == yes ]]; then
    log "Importing demo dump..."
    mysql -u root "$DB_NAME" < "$SRC_DIR/app/example_files/marketplace_backup.sql"
  else
    log "Running migrations..."
    (cd "$APP_DIR" && php artisan migrate --force)
  fi
else
  log "Database already has $TABLE_COUNT tables - leaving it alone."
fi

# --- php-fpm + nginx ---------------------------------------------------------
log "Configuring PHP-FPM and nginx..."
sed -i -E "s|^user = .*|user = ${WEB_USER}|; s|^group = .*|group = ${WEB_USER}|" "$FPM_POOL"
sed -i -E "s|^;?listen.owner = .*|listen.owner = ${WEB_USER}|; s|^;?listen.group = .*|listen.group = ${WEB_USER}|" "$FPM_POOL"
sed -i -E "s|^listen = .*|listen = ${FPM_SOCK}|" "$FPM_POOL"
sed -i -E "s|^;?cgi.fix_pathinfo=.*|cgi.fix_pathinfo=0|" /etc/php.ini 2>/dev/null || true

cat > "$NGINX_CONF" <<NGINX
server {
    listen 127.0.0.1:${NGINX_PORT};
    server_name _;

    root ${APP_DIR}/public;
    index index.php;

    # Privacy: no access log for an onion service.
    access_log off;
    error_log  /var/log/nginx/thevault-error.log warn;

    server_tokens off;
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options DENY;
    add_header Referrer-Policy no-referrer;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
        limit_except GET POST HEAD { deny all; }
    }

    location ~ \.php\$ {
        try_files \$uri =404;
        fastcgi_pass unix:${FPM_SOCK};
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\. { deny all; }
    location ~* \.(ini|log|conf|sh|md|env)\$ { deny all; }
}
NGINX
# Rebind the distro's default :80 server to loopback so nothing is exposed publicly.
if [[ -f /etc/nginx/nginx.conf ]]; then
  sed -i -E 's|^(\s*)listen\s+80( default_server)?;|\1listen 127.0.0.1:8081;|; s|^(\s*)listen\s+\[::\]:80( default_server)?;|\1# listen [::]:80;|' /etc/nginx/nginx.conf
fi

chown -R "$WEB_USER":"$WEB_USER" "$APP_DIR/storage" "$APP_DIR/bootstrap/cache"
chmod -R u+rwX,g+rwX "$APP_DIR/storage" "$APP_DIR/bootstrap/cache"

if command -v getenforce >/dev/null 2>&1 && [[ "$(getenforce)" == Enforcing ]]; then
  log "SELinux enforcing - applying contexts..."
  setsebool -P httpd_can_network_connect_db 1 || true
  chcon -R -t httpd_sys_rw_content_t "$APP_DIR/storage" "$APP_DIR/bootstrap/cache" || true
fi

nginx -t
systemctl enable --now "$FPM_SERVICE" nginx
systemctl restart "$FPM_SERVICE" nginx

# --- tor ---------------------------------------------------------------------
log "Configuring Tor onion service..."
TOR_USER=""
for u in toranon debian-tor tor; do
  if getent passwd "$u" >/dev/null; then TOR_USER="$u"; break; fi
done
[[ -n "$TOR_USER" ]] || die "Could not find the Tor service user."

mkdir -p "$HS_DIR"
if [[ -n "$HS_KEY_DIR" ]]; then
  [[ -f "$HS_KEY_DIR/hs_ed25519_secret_key" ]] || die "HS_KEY_DIR has no hs_ed25519_secret_key."
  log "Restoring existing onion key from $HS_KEY_DIR"
  cp -a "$HS_KEY_DIR"/hs_ed25519_secret_key "$HS_KEY_DIR"/hs_ed25519_public_key "$HS_KEY_DIR"/hostname "$HS_DIR"/
fi
chown -R "$TOR_USER":"$TOR_USER" "$HS_DIR"
chmod 700 "$HS_DIR"

TORRC=/etc/tor/torrc
sed -i '/^# BEGIN thevault/,/^# END thevault/d' "$TORRC"
{
  echo "# BEGIN thevault"
  echo "HiddenServiceDir ${HS_DIR}/"
  echo "HiddenServicePort 80 127.0.0.1:${NGINX_PORT}"
  if [[ -n "$BRIDGE_LINES" ]]; then
    OBFS=""
    for c in lyrebird obfs4proxy; do
      command -v "$c" >/dev/null 2>&1 && OBFS="$(command -v "$c")" && break
    done
    if [[ -z "$OBFS" ]]; then
      for p in lyrebird obfs4proxy; do
        if [[ $PM == dnf ]]; then dnf install -y "$p" >/dev/null 2>&1 || true; else apt-get install -y "$p" >/dev/null 2>&1 || true; fi
        for c in lyrebird obfs4proxy; do
          command -v "$c" >/dev/null 2>&1 && OBFS="$(command -v "$c")" && break 2
        done
      done
    fi
    [[ -n "$OBFS" ]] || die "BRIDGE_LINES set but no obfs4 client (lyrebird/obfs4proxy) could be installed from this distro's repos."
    echo "UseBridges 1"
    echo "ClientTransportPlugin obfs4 exec ${OBFS}"
    while IFS= read -r line; do
      [[ -n "$line" ]] && echo "Bridge ${line#Bridge }"
    done <<< "$BRIDGE_LINES"
  fi
  echo "# END thevault"
} >> "$TORRC"

systemctl enable "$TOR_SERVICE"
systemctl restart "$TOR_SERVICE"

log "Waiting for the onion hostname..."
for _ in $(seq 1 60); do
  [[ -s "$HS_DIR/hostname" ]] && break
  sleep 2
done
[[ -s "$HS_DIR/hostname" ]] || die "No hostname generated. Check: journalctl -u $TOR_SERVICE"
ONION="$(cat "$HS_DIR/hostname")"
setenv APP_URL "http://${ONION}"
(cd "$APP_DIR" && php artisan config:clear >/dev/null 2>&1 || true)

# --- smoke tests -------------------------------------------------------------
log "Local smoke test (nginx -> php-fpm -> app)..."
CODE="$(curl -s -o /dev/null -w '%{http_code}' "http://127.0.0.1:${NGINX_PORT}/" || true)"
echo "  http://127.0.0.1:${NGINX_PORT}/ -> HTTP ${CODE}"
[[ "$CODE" == 200 || "$CODE" == 302 ]] || warn "Unexpected status. Check /var/log/nginx/thevault-error.log and $APP_DIR/storage/logs."

log "Tor bootstrap status:"
journalctl -u "$TOR_SERVICE" --no-pager 2>/dev/null | grep -i "bootstrapped" | tail -2 || true

cat <<DONE

============================================================
 theVault is provisioned.
   Onion address : http://${ONION}
   DB password   : saved in ${CREDS_FILE}
   Onion key dir : ${HS_DIR}   <-- BACK THIS UP to keep the address
 Open the address in Tor Browser. A new service can take a few
 minutes to become reachable. No inbound web port was opened.
============================================================
DONE

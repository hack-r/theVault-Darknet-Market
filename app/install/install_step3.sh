echo "Let's continue. First, a bit more firewall setup..."
echo "If you don't use firewalld or don't want to, you can substitute iptables, ufw, etc."
sudo dnf install firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
#sudo firewall-cmd --add-port=9200/tcp --permanent
#sudo firewall-cmd --reload

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

echo "Double-check that the required modules are installed and available..."
sudo dnf install php-mbstring php-xml php-gmp php-curl php-gd composer unzip -y


echo "Ensure we have nodejs/npm..."
sudo dnf install nodejs npm -y
echo "Download elasticsearch vector DB...more versions available on elastic.co..."
echo "If anything goes wrong, use a package manager installation or the docker container. Both are available on their website."
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
ES_VERSION="8.17.2"
ES_TAR="elasticsearch-${ES_VERSION}-linux-x86_64.tar.gz"
ES_URL="https://artifacts.elastic.co/downloads/elasticsearch/${ES_TAR}"
ES_SHA512_URL="https://artifacts.elastic.co/downloads/elasticsearch/${ES_TAR}.sha512"
ES_ASC_URL="https://artifacts.elastic.co/downloads/elasticsearch/${ES_TAR}.asc"
INSTALL_DIR="/usr/local/elasticsearch"

sudo dnf install -y wget gpg
sudo mkdir -p ${INSTALL_DIR}
cd ${INSTALL_DIR}

echo "Downloading Elasticsearch..."
wget ${ES_URL}
wget ${ES_SHA512_URL}
wget ${ES_ASC_URL}

echo "Verifying SHA512 checksum..."
sha512sum -c ${ES_TAR}.sha512

if [ $? -ne 0 ]; then
    echo "SHA512 checksum verification failed!"
    exit 1
fi

echo "Extracting Elasticsearch..."
tar -xzf ${ES_TAR} --strip-components=1

echo "Cleaning up..."
rm ${ES_TAR} ${ES_TAR}.sha512 ${ES_TAR}.asc


echo "Making an elasticsearch user..."
sudo useradd -r -s /bin/false elasticsearch

echo "Create an elasticsearch service..."
cat <<EOF | sudo tee /etc/systemd/system/elasticsearch.service
[Unit]
Description=Elasticsearch
After=network.target

[Service]
Type=simple
User=root
ExecStart=${INSTALL_DIR}/bin/elasticsearch
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
sudo iptables -A INPUT -p tcp --dport 9200 -j ACCEPT

echo "Elasticsearch installation completed successfully!"

echo "If this provides any info on elasticsearch, setup succeeded: "
curl -X GET "localhost:9200"

echo "Setting up an OpenJDK environment variable. If you're not using Fedora or if the version has changed, you must edit the next line or do it manually..."
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-21.0.5.0.11-1.fc40.x86_64/bin/java"
echo 'JAVA_HOME="/usr/lib/jvm/java-21-openjdk-21.0.5.0.11-1.fc40.x86_64/bin/java"' >> ~/.bashrc
source ~/.bashrc

echo "You may need to disable HTTPS in elasticsearch. You could setup SSL, but Tor typically replaces it with its own encryption. sudo nano /etc/elasticsearch/elasticsearch.yml"


cd /var/www/thevault
composer install
npm install
npm run prod
cp .env.example .env
php artisan key:generate

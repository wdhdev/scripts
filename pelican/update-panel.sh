cd /var/www/pelican
php artisan down
curl -L https://github.com/pelican-dev/panel/releases/latest/download/panel.tar.gz | tar -xzv
chmod -R 755 storage/* bootstrap/cache
export COMPOSER_ALLOW_SUPERUSER=1;
composer install --no-dev --optimize-autoloader
php artisan view:clear
php artisan config:clear
php artisan migrate --seed --force
chown -R www-data:www-data /var/www/pelican/* 
php artisan queue:restart
php artisan up

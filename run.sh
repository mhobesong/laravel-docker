#Give time to mysql server to boot
sleep 5

vendor/bin/phpunit

php artisan migrate

/usr/sbin/apache2ctl -D FOREGROUND

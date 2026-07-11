#!/bin/bash
set -e

# Wait for MySQL database to be ready
if [ -f .env ]; then
    DB_HOST=$(grep '^DB_HOST=' .env | cut -d= -f2 | tr -d '\r')
    DB_USERNAME=$(grep '^DB_USERNAME=' .env | cut -d= -f2 | tr -d '\r')
    DB_PASSWORD=$(grep '^DB_PASSWORD=' .env | cut -d= -f2 | tr -d '\r')
fi

DB_HOST=${DB_HOST:-mysql-service}
DB_USERNAME=${DB_USERNAME:-chat_user}
DB_PASSWORD=${DB_PASSWORD:-chat_password}

echo "Waiting for MySQL to be ready at $DB_HOST..."
until mysqladmin ping -h"$DB_HOST" -u"$DB_USERNAME" -p"$DB_PASSWORD" --skip-ssl --silent; do
    sleep 1
done
echo "MySQL is ready!"

composer install

# Only generate APP_KEY if it's not set
if [ -f .env ] && [ -z "$(grep '^APP_KEY=' .env | cut -d= -f2- | tr -d '\r')" ]; then
    echo "Generating Application Key..."
    php artisan key:generate
else
    echo "Application Key already exists."
fi

php artisan migrate
php artisan serve --host=0.0.0.0 --port=8000
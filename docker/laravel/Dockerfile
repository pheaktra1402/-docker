FROM php:8.4-cli

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    default-mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring bcmath gd zip pcntl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2.9 /usr/bin/composer /usr/bin/composer

# បញ្ជាឱ្យ Laravel បើកដំណើរការ server លើ port 8000 និងអនុញ្ញាតឱ្យម៉ាស៊ីនខាងក្រៅចូលមើលបាន
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]


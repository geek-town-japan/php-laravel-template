FROM php:8.5.3-fpm-alpine3.22

ENV COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer 

COPY --from=composer:2.9.5 /usr/bin/composer /usr/bin/composer

RUN apk add --no-cache \
    postgresql-dev \
    && docker-php-ext-install \
        pdo_pgsql

COPY ./php.ini /usr/local/etc/php/php.ini

WORKDIR /data

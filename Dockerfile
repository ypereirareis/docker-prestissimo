FROM php:7-cli

MAINTAINER Yannick Pereira-Reis <yannick.pereira.reis@gmail.com>

ARG COMPOSER_VERSION=

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libbz2-dev \
    libicu-dev \
    curl \
    git \
    subversion \
    unzip \
    sudo \
  && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install zip bz2 mbstring intl \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini
RUN php --version

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN [ ! -z "${COMPOSER_VERSION}" ] \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version="${COMPOSER_VERSION}" \
  || php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
RUN composer --version

# PRESTISSIMOOOOOOOOOO !!
RUN composer global require hirak/prestissimo

VOLUME ["/srv"]
WORKDIR /srv

##########################################################################################################
# No ENTRYPOINT in my docker images to let people execute scripts or commands before using the image tools
##########################################################################################################

CMD []

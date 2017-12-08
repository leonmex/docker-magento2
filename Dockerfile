################################################################################
# Docker for Magento 2 development
#
# @author     Noel Barrera <nbarrera@magentobi.com>
################################################################################

################################################################################
# Base image and maintainer nginx
################################################################################

FROM nginx:1.12 

# Minimum system requirements
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \ 
    libicu-dev \ 
    libjpeg62-turbo-dev \ 
    libmcrypt-dev \ 
    libxslt1-dev \ 
    sendmail-bin \ 
    sendmail \ 
    sudo \ 
    cron \ 
    rsyslog \ 
    mysql-server \
    mysql-client \ 
    git \
    curl \
    wget \
    unzip \
    tar \
    composer \
    php7.0-fpm \
    redis-server \
    vim

# PHP requirements
RUN apt-get install -y \
    php7.0-mysql php7.0-curl php7.0-gd php7.0-imagick php7.0-intl \
    php7.0-mbstring php-soap php7.0-xmlrpc php7.0-xsl mcrypt php7.0-mcrypt php7.0-dev php7.0-zip 

RUN pecl install timezonedb

# Install the 2.4 version of xdebug that's compatible with php7
RUN pecl install -o -f xdebug-2.4.0

################################################################################
# Build instructions
################################################################################
ENV PHP_HOST phpfpm
ENV PHP_PORT 9000
ENV APP_MAGE_MODE default

## Remove default nginx configs.
RUN rm -f /etc/nginx/conf.d/*

## Copy nginx configuration
COPY conf/nginx /etc/nginx

## Copy magento cron configuration
COPY conf/cron.d/magento /etc/cron.d/magento

## Copy shel for create magento user
COPY shell/createMagentoUser.sh /var/www/

## Copy shel for create magento user
COPY phpfcgi/www.conf /etc/php/7.0/fpm/pool.d/

## Install magerun
RUN curl -sS https://files.magerun.net/n98-magerun2.phar > /usr/bin/mr2 && chmod +x /usr/bin/mr2

## Expose ports
EXPOSE 80 443

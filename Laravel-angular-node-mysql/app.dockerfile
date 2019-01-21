#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

FROM php:7.1-fpm

MAINTAINER Tung Pham <tung.pham@savvycomsoftware.com>

#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#
# Installing tools and PHP extentions using "apt", "docker-php", "pecl",
#

# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng12-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        #libpng12-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev\
	mysql-client \
	libzip-dev \
        zip
#RUN pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt
# Install the PHP mcrypt extention
RUN docker-php-ext-install mcrypt

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP pdo_pgsql extention
RUN docker-php-ext-install pdo_pgsql

#####################################
# gd:
#####################################

# Install the PHP gd library
RUN docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

RUN docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip
#COPY entrypoint.sh /opt/bin/entrypoint.sh
#RUN chmod +x /var/www/entrypoint.sh
#ADD crontab /etc/cron.d/php-cron

#RUN chmod 0644 /etc/cron.d/php-cron

# Create the log file to be able to run tail
#RUN touch /var/log/cron.log

#Install Cron
RUN apt-get update
RUN apt-get -y install cron nano vim

#ENTRYPOINT /bin/bash
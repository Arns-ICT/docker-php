FROM php:8.2-apache

# Install latest updates
RUN apt update && apt full-upgrade -y

# Install php package installer
RUN  --mount=type=bind,from=mlocati/php-extension-installer:latest,source=/usr/bin/install-php-extensions,target=/usr/local/bin/install-php-extensions \
      install-php-extensions bcmath exif gd imagick intl mysqli pdo_mysql sockets ssh2 zip


# Configure Apache
RUN a2enmod deflate
RUN a2enmod rewrite

RUN sed -i 's|Options Indexes FollowSymLinks|Options FollowSymLinks|g' /etc/apache2/apache2.conf
RUN sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf

RUN sed -i 's|ServerTokens OS|ServerTokens Prod|g' /etc/apache2/conf-enabled/security.conf
RUN sed -i 's|ServerSignature On|ServerSignature Off|g' /etc/apache2/conf-enabled/security.conf

# Configure PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN sed -i 's|expose_php = On|expose_php = Off|g' $PHP_INI_DIR/php.ini
RUN sed -i 's|upload_max_filesize = 2M|upload_max_filesize = 64M|g' $PHP_INI_DIR/php.ini
RUN sed -i 's|post_max_size = 8M|post_max_size = 64M|g' $PHP_INI_DIR/php.ini
RUN sed -i 's|output_buffering = 4096|output_buffering = Off|g' $PHP_INI_DIR/php.ini
RUN sed -i 's|;upload_tmp_dir =|upload_tmp_dir = /tmp|g' $PHP_INI_DIR/php.ini

# clean up files
RUN apt clean


CMD ["apache2-foreground"]
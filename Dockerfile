FROM php:8.1-fpm-alpine

# PHP config through env variables
ENV PHP_MEMORY_LIMIT="-1" \
  PHP_FPM_MEMORY_LIMIT="1G" \
  \
  PHP_MAX_EXECUTION_TIME="0" \
  PHP_FPM_MAX_EXECUTION_TIME="30" \
  \
  PHP_MAX_INPUT_TIME="-1" \
  PHP_FPM_MAX_INPUT_TIME="60" \
  \
  PHP_ERROR_REPORTING="E_ALL & ~E_DEPRECATED & ~E_STRICT" \
  PHP_FPM_ERROR_REPORTING="E_ALL & ~E_DEPRECATED & ~E_STRICT" \
  \
  PHP_POST_MAX_SIZE="8M" \
  PHP_FPM_POST_MAX_SIZE="50M" \
  \
  PHP_UPLOAD_MAX_FILESIZE="8M" \
  PHP_FPM_UPLOAD_MAX_FILESIZE="50M" \
  \
  PHP_MAX_FILE_UPLOADS="20" \
  PHP_FPM_MAX_FILE_UPLOADS="20" \
  \
  PHP_FPM_MAX_CHILDREN="20" \
  PHP_FPM_START_SERVERS="8" \
  PHP_FPM_MIN_SPARE_SERVERS="5" \
  PHP_FPM_MAX_SPARE_SERVERS="10"

# Extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions apcu \
    gd \
    exif \
    memcached \
    fileinfo \
    intl \
    pdo_mysql \
    imagick \
    @composer-2 \
  && apk add --no-cache nano git

CMD ["php-fpm"]

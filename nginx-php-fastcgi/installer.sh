#!/bin/ash
echo RECONFIGURE nginx - Please REMEMBER to add bin/ash on alpine - 
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.orig
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
ln -ns /opt/loitd/nginx.conf /etc/nginx/nginx.conf
ln -ns /opt/loitd/default.conf /etc/nginx/conf.d/default.conf
ln -ns /opt/loitd/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
echo BEGIN INSTALLING php7+openrc - The rc-update tool is a part of the openrc package - 
apk --no-cache add openrc php7 php7-fpm php7-json php7-zlib php7-xml php7-phar php7-iconv php7-mcrypt curl php7-curl php7-openssl php7-gd
mkdir -p /var/run/php
chown nginx:nginx /var/run/php/
echo SETTING PHP ENV VARS
PHP_FPM_USER="nginx"
PHP_FPM_GROUP="nginx"
PHP_FPM_LISTEN_MODE="0660"
PHP_MEMORY_LIMIT="512M"
PHP_MAX_UPLOAD="5M"
PHP_MAX_FILE_UPLOAD="10"
PHP_MAX_POST="10M"
PHP_DISPLAY_ERRORS="On"
PHP_DISPLAY_STARTUP_ERRORS="On"
PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
PHP_CGI_FIX_PATHINFO=0
echo SETTING www.conf
sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf #uncommenting line 
echo SETTING php.ini
sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini

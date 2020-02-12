echo START nginx + php7 + add to default start
rc-service nginx start
rc-service php-fpm7 start
rc-update add nginx default
rc-update add php-fpm7 default
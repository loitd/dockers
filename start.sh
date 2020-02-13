#!/bin/ash
echo START nginx + php7 + add to default start
rc-service nginx restart
rc-service php-fpm7 restart
rc-update add nginx default
rc-update add php-fpm7 default
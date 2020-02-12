FROM nginx:1.17.8-alpine
LABEL   com.innneka.author="Tran Duc Loi" \
        com.inneka.email="loitranduc@gmail.com" \
        com.inneka.license=MIT \ 
        com.inneka.version="1.0" \
        com.inneka.description="Nginx + PHP7-FPM + Wordpress + FastCGI-Cache"

# ALPINE_VERSION=3.10 (used by nginx)
# NGINX_VERSION=1.17.8
# PHP_VERSION=7.0

# To get the config file
# $ docker run --name tmp-nginx -d nginx:1.17.8-alpine
# $ docker cp tmp-nginx:/etc/nginx/nginx.conf ./nginx.conf
# $ docker rm -f tmp-nginx
RUN mkdir -p /etc/nginx/snippets && \
mkdir -p /var/www/html && \
mkdir -p /opt/loitd && \
chmod -R 755 /opt/loitd

# With custom nginx configuration file
# In dockerfile
ADD --chown=nginx:nginx nginx.conf /opt/loitd
ADD --chown=nginx:nginx conf.d/default.conf /opt/loitd
ADD --chown=nginx:nginx snippets/fastcgi-php.conf /opt/loitd
ADD ./installer.sh /opt/loitd 
ADD ./start.sh /opt/loitd 
ADD https://wordpress.org/latest.tar.gz /var/www/html

# docker run --name mynginx -v /host/path/nginx.conf:/etc/nginx/nginx.conf:ro -d -p 8080:80 nginx
# docker build -t nginx-php-fastcgi-img . ---> to build this Dockerfile
# docker run --name nginx-php-fastcgi-app -d -p 8080:80 nginx-php-fastcgi-img ---> to run this image
RUN /opt/loitd/installer.sh

WORKDIR /var/www/html
# Remove default.conf
# Install php7
# Create PHP running dir
# Grant permissions to nginx
ENTRYPOINT [ "/opt/loitd/start.sh" ]
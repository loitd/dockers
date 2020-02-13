FROM nginx:1.17.8-alpine
LABEL   com.innneka.author="Tran Duc Loi" \
        com.inneka.email="loitranduc@gmail.com" \
        com.inneka.license=MIT \ 
        com.inneka.version="1.0" \
        com.inneka.description="Nginx + PHP7-FPM + Wordpress + FastCGI-Cache"

RUN mkdir -p /etc/nginx/snippets && \
    mkdir -p /var/www/html && \
    mkdir -p /opt/loitd && \
    mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.orig && \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig 

ADD --chown=nginx:nginx nginx.conf /etc/nginx/
ADD --chown=nginx:nginx conf.d/default.conf /etc/nginx/conf.d/
ADD --chown=nginx:nginx snippets/fastcgi-php.conf /etc/nginx/snippets/

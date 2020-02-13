FROM nginx:alpine
LABEL   com.innneka.author="Tran Duc Loi" \
        com.inneka.email="loitranduc@gmail.com" \
        com.inneka.license=MIT \ 
        com.inneka.version="1.0" \
        com.inneka.description="Nginx + PHP7-FPM + Wordpress + FastCGI-Cache" \
        maintainer="loitranduc <loitranduc@gmail.com>"

# To get the config file
RUN mkdir -p /etc/nginx/snippets && \
    mkdir -p /var/www/html/default && \
    mkdir -p /opt/loitd && \
    mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.orig && \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

# These files must be in a same folder with Dockerfile's folder
ADD --chown=nginx:nginx nginx.conf /etc/nginx/
ADD --chown=nginx:nginx conf.d/default.conf /etc/nginx/conf.d/
ADD --chown=nginx:nginx snippets/fastcgi-php.conf /etc/nginx/snippets/
ADD --chown=nginx:nginx snippets/snakeoil.conf /etc/nginx/snippets/
ADD --chown=nginx:nginx start.sh /opt/loitd/
ADD --chown=nginx:nginx phpinfo.php /var/www/html/default/
# ADD https://wordpress.org/latest.tar.gz /var/www/html

# RUN echo $PHPFPMURL && sed -i "s|fastcgi_pass\s*127.0.0.1:9000;|fastcgi_pass ${PHPFPMURL};|g" /etc/nginx/conf.d/default.conf

# CMD [ "/opt/loitd/start.sh"]
# ENTRYPOINT [ "/opt/loitd/start.sh" ]
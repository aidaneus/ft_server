FROM debian:buster

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y nginx

RUN apt-get -y install php php-fpm php-mysql php-curl php-intl php-soap php-xml php-xmlrpc
RUN apt-get install -y openssl
RUN apt-get -y install mariadb-server wget

#generate ssl
RUN openssl req -x509 -nodes -newkey rsa:4096 -days 365 -keyout /etc/ssl/private/nhildred.key -out /etc/ssl/certs/nhildred.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=42 School/OU=nhildred/CN=cert"

#nginx and autoindex
COPY srcs/*.sh ./
COPY srcs/ft_server /etc/nginx/sites-available
COPY srcs/ft_server_off /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/ft_server /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default
RUN chmod +x autoindex_off.sh
RUN chmod +x autoindex_on.sh

#wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN mv wordpress /var/www/html/
RUN rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/html/wordpress
RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*

#phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.2-english.tar.gz
RUN mv phpMyAdmin-5.0.2-english/ /var/www/html/phpmyadmin 
RUN rm -rf phpMyAdmin-5.0.2-english.tar.gz
COPY srcs/phpmyadmin.inc.php /var/www/html/phpmyadmin

EXPOSE 80 443

CMD bash init.sh 

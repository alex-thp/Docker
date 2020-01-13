FROM debian:buster

RUN apt-get update -y && apt-get -y install wget
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz && tar -xvf phpMyAdmin-4.9.4-all-languages.tar.gz
RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz && tar -xvf latest-fr_FR.tar.gz
RUN mv phpMyAdmin-4.9.4-all-languages phpMyAdmin
RUN apt-get install -y mariadb-server
RUN apt-get install -y nginx
RUN mv wordpress /var/www/html && mv phpMyAdmin /var/www/html
RUN apt-get install -y php-fpm php-mysql
COPY default etc/nginx/sites-available/.
CMD service php7.3-fpm start &&\
openssl req -nodes -new -x509 -keyout ./etc/nginx/server.key -out ./etc/nginx/certificate -subj "/C=FR/ST=Paris/L=Clichy/O=42/CN=localhost42.com"\
&& nginx && service mysql start\
&& bash
#EXPOSE 80 -> Ouvre le port 80 du container et permet l'utilisation de -P qui lie automatiquement un port de la machine au container sans demander à l'utilisateur
#Avec docker ps, on peut récupérer le port qui a été utilisé
#RUN ls *

FROM ubuntu

ENV TERM=xterm-color

RUN apt-get update

#Install editor for debuging
RUN apt-get install -y bash nano curl

#Install apache2
RUN apt-get install -y apache2
RUN a2enmod rewrite
COPY ./apache2/000-default.conf/ /etc/apache2/sites-available/000-default.conf

#timezone data
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

#Install php
RUN apt-get install -y php7.2 
RUN apt-get install -y php7.2-fpm 
RUN apt-get install -y php7.2-cli 
RUN apt-get install -y php7.2-curl 
RUN apt-get install -y php7.2-mysqli 
RUN apt-get install -y php7.2-sqlite3 
RUN apt-get install -y php7.2-dom 
RUN apt-get install -y libapache2-mod-php 
RUN apt-get install -y php7.2-mysql
RUN apt-get install -y php7.2-gd 
RUN apt-get install -y php7.2-xml 
RUN apt-get install -y php7.2-mbstring 
RUN apt-get install -y php7.2-iconv 
RUN apt-get install -y php7.2-json 
RUN apt-get install -y php7.2-phar 
RUN apt-get install -y php7.2-xmlwriter 
RUN apt-get install -y php7.2-tokenizer

#Add application files
COPY ./app/ /var/www/

RUN rm -r /var/www/html

RUN mv /var/www/public /var/www/html

WORKDIR /var/www

#Install composer
RUN apt-get install -y zip unzip
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

#Install app dependencies
RUN php composer.phar install

RUN php artisan key:generate

COPY ./run.sh /
RUN chmod 777 /run.sh

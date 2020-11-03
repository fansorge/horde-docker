#FROM php:7.4.12-apache
FROM ubuntu:18.04
LABEL maintainer "mobilemailer@web.de"

ENV TZ=Europe/Berlin
# TODO: figure out a smart automatic way to discover the path
ARG PHP_ETC_DIR=/etc/php/7.2

ENV DB_HOST db
ENV DB_PORT 3306
ENV DB_NAME hordedb
ENV DB_USER hordeuser
ENV DB_PASS nicepassword
ENV DB_PROTOCOL SOCKET
ENV DB_DRIVER mysqli
ENV HORDE_TEST_DISABLE false

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
 && apt-get -y update && apt-get -y upgrade 

RUN apt-get install -y apache2 libapache2-mod-php mysql-client gnupg2 openssl php-pear \
	php-horde php-horde-imp php-horde-groupware php-horde-ingo php-horde-lz4 \
	php-imagick php-dev php-memcache php-memcached php-net-sieve \
 && pear channel-update pear.php.net \
#&& pear --force upgrade-all \
#&& apt-get -y install --reinstall php-xml \
 && pear install Net_DNS2 \
 && pecl install lzf

RUN echo extension=lzf.so > $PHP_ETC_DIR/mods-available/lzf.ini \
 && phpenmod lzf \
 && echo extension=horde_lz4.so > $PHP_ETC_DIR/mods-available/horde_lzf.ini \
 && phpenmod horde_lzf \
 && pear channel-discover pear.horde.org \
 && pear channel-update pear.horde.org \
 && pear --force upgrade-all \
# && apt-get -y install wget \
# && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
# && tar -C /usr/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
# && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
# && apt-get -y remove --purge wget \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY info.php /var/www/html/info.php

#RUN mv /etc/horde /etc/.horde
#COPY horde-init.sh /etc/my_init.d/horde-init.sh
#COPY horde-base-settings.inc /etc/horde-base-settings.inc
#RUN chmod +x /etc/my_init.d/horde-init.sh

#RUN mkdir -p /etc/service/apache2
#COPY run.sh /etc/service/apache2/run
#RUN chmod +x /etc/service/apache2/run && \
#	a2dissite 000-default && a2disconf php-horde

#RUN mkdir -p /etc/apache2/scripts
#COPY proxy_client_ip.php /etc/apache2/scripts/proxy_client_ip.php

#COPY apache-horde.conf /etc/apache2/sites-available/horde.conf
#RUN a2ensite horde

#COPY docker-entrypoint.sh /

#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["/sbin/my_init"]

#VOLUME /etc/horde

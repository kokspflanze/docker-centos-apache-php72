FROM centos:latest

MAINTAINER "KoKsPfLaNzE" <kokspflanze@protonmail.com>

ENV container docker

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN yum -y install yum-utils
RUN yum-config-manager --enable remi-php72

# normal updates
RUN yum -y update

# php && httpd
#RUN yum -y install mod_php71w php71w-opcache php71w-cli php71w-common php71w-gd php71w-intl php71w-mbstring php71w-mcrypt php71w-mysql php71w-mssql php71w-pdo php71w-pear php71w-soap php71w-xml php71w-xmlrpc
RUN yum -y install php72 php72-php php72-php-opcache php72-php-bcmath php72-php-cli php72-php-common php72-php-gd php72-php-intl php72-php-json php72-php-mbstring php72-php-pdo php72-php-pdo-dblib php72-php-pear php72-php-pecl-mcrypt php72-php-xmlrpc php72-php-xml php72-php-mysql php72-php-soap httpd

# tools
RUN yum -y install epel-release iproute at curl crontabs git

# pagespeed
RUN curl -O https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm \
 && rpm -U mod-pagespeed-*.rpm \
 && yum clean all \
 && php72 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php72 composer-setup.php --install-dir=bin --filename=composer \
 && php72 -r "unlink('composer-setup.php');" \
 && rm -rf /etc/localtime \
 && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && ln -s /bin/php72 /bin/php

# we want some config changes
COPY config/50-php_settings.ini /etc/opt/remi/php72/php.d/
COPY config/v-host.conf /etc/httpd/conf.d/

# create webserver-default directory
RUN mkdir -p /var/www/page/public

EXPOSE 80

RUN systemctl enable httpd \
 && systemctl enable crond

CMD ["/usr/sbin/init"]

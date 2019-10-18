# docker-centos-apache-php7.2
Docker with CentOS 8, systemd, Apache2, PHP7.2, crond, composer and pagespeed

# Pull

```
docker pull kokspflanze/centos-apache-php72
```

# Running Container

```
docker run -v /opt/docker/docker_test/data:/var/www/page --restart=always -d -it kokspflanze/centos-apache-php72
```

# Attach Container

```
docker exec kokspflanze/centos-apache-php72 /bin/bash
```

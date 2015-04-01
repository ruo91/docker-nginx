#
# Dockerfile - Nginx
#
FROM ubuntu:14.04
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# Change the repository
RUN sed -i 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

# Nginx
RUN apt-get update && apt-get install -y wget python-software-properties software-properties-common supervisor \
 && echo "deb http://nginx.org/packages/ubuntu/ `lsb_release -sc` nginx" > /etc/apt/sources.list.d/nginx.list \
 && wget -q -O- "http://nginx.org/keys/nginx_signing.key" | apt-key add - \
 && apt-get update && apt-get install -y nginx

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Port
EXPOSE 80

# Daemon
CMD ["/usr/bin/supervisord"]
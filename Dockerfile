FROM    centos:centos7
MAINTAINER Damien <cdams@outlook.fr>

## RHEL/CentOS 6 ##
RUN     rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Default programs + Install Node.js and npm
RUN     yum install -y git bzip2 rubygems tar nodejs npm --enablerepo=epel

# Install sass/compass
RUN gem install sass && gem install compass

# Create non-root user
RUN /usr/sbin/useradd --create-home --shell /bin/bash user && echo 'root:admin' | chpasswd

# Useful command to clean docker images / containers
#docker rm -f `docker ps --no-trunc -aq` && docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi -f
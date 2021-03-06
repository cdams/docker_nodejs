FROM    centos:centos7
MAINTAINER Damien <cdams@outlook.fr>

## RHEL/CentOS 7 64-Bit ##
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-1.noarch.rpm

# Default programs + Install Node.js and npm
RUN     yum install -y git bzip2 rubygems ruby-devel make tar nodejs npm --enablerepo=epel

# Install sass/compass
RUN gem install sass && gem install compass

# Create non-root user
RUN /usr/sbin/useradd --create-home --shell /bin/bash user && echo 'root:admin' | chpasswd

# Install Yo stack
RUN npm install -g yo

# User permissions
RUN mkdir -p /.config/configstore /.local /.cache
RUN chown -R user /.npm /usr/lib /.config /.local /.cache

# Useful command to clean docker images / containers
#docker rm -f `docker ps --no-trunc -aq` && docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi -f
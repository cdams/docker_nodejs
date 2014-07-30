FROM    centos:centos6
MAINTAINER Damien <cdams@outlook.fr>

## RHEL/CentOS 7 64-Bit ##
#RUN     rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm

## RHEL/CentOS 6 ##
RUN     rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum groupinstall -y "Development tools"

# Default programs
RUN     yum install -y openssh-server openssh-clients passwd git unzip bzip2 ruby-full rubygems tar

# Install sass/compass
RUN gem install sass
RUN gem install compass

# Install Node.js and npm
RUN 	yum install -y nodejs --enablerepo=epel
RUN		curl -L http://npmjs.org/install.sh | clean=no sh

# Install Yo stack
RUN npm install -g yo generator-angular generator-webapp

# Create non-root user
RUN /usr/sbin/useradd --create-home --password plop --shell /bin/bash user
RUN passwd -f -u user && su - user

#docker rm -f `docker ps --no-trunc -aq` && docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi -f
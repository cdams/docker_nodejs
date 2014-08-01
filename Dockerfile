FROM    centos:centos7
MAINTAINER Damien <cdams@outlook.fr>

## RHEL/CentOS 7 64-Bit ##
RUN     rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm

## RHEL/CentOS 6 ##
#RUN     rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
#yum groupinstall -y "Development tools"

# Default programs
RUN     yum install -y openssh-server sudo openssh-clients passwd git unzip bzip2 ruby-full rubygems tar

# Install sass/compass
RUN gem install sass
RUN gem install compass

# Install Node.js and npm
RUN 	yum install -y nodejs npm --enablerepo=epel

# Create non-root user
RUN /usr/sbin/useradd --create-home --password plop --shell /bin/bash user
RUN passwd -f -u user #&& mkdir -p /.npm && chown -R user /.npm && chown -R user /usr/lib && chown -R user /lib


# Install Yo stack
RUN npm install -g yo generator-angular generator-webapp #--no-bin-links


# Avoid the question at the yeoman first run
RUN mkdir -p /.config/configstore & chown -R user /.config
RUN echo "clientId: 90670452932" > /.config/configstore/insight-yo.yml
RUN echo "optOut: false" >> /.config/configstore/insight-yo.yml


USER user
WORKDIR /home/user

#docker rm -f `docker ps --no-trunc -aq` && docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi -f
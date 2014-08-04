FROM    centos:centos7
MAINTAINER Damien <cdams@outlook.fr>

## RHEL/CentOS 7 64-Bit ##
RUN     rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm

## RHEL/CentOS 6 ##
#RUN     rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
#yum groupinstall -y "Development tools"

# Default programs + Install Node.js and npm
RUN     yum install -y passwd git bzip2 rubygems tar nodejs npm --enablerepo=epel

# Install Yo stack
RUN npm install -g yo generator-angular generator-webapp #--no-bin-links

# Install sass/compass
RUN gem install sass && gem install compass

# Create non-root user
RUN /usr/sbin/useradd --create-home --password plop --shell /bin/bash user && passwd -f -u user && echo 'root:admin' | chpasswd

# Avoid the question at the yeoman first run
RUN mkdir -p /.config/configstore && mkdir /.local && mkdir /.cache
#RUN echo "clientId: 90670452932" > /.config/configstore/insight-yo.yml
#RUN echo "optOut: false" > /.config/configstore/insight-yo.yml
RUN chown -R user /.config && chown -R user /.npm && chown -R user /.local && chown -R user /.cache  && chown -R user /usr/lib

USER user
WORKDIR /home/user

RUN echo "/home/user/node_modules" > .dockerignore
RUN echo "/tmp/node_modules" >> .dockerignore
RUN mkdir /tmp/node_modules && ln -s /tmp/node_modules/ /home/user/node_modules

#docker rm -f `docker ps --no-trunc -aq` && docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi -f
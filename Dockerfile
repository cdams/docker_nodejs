FROM    centos:centos7
MAINTAINER Damien <cdams@outlook.fr>

## RHEL/CentOS 7 64-Bit ##
RUN     rpm -Uvh http://dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm
#yum groupinstall -y "Development tools"

## RHEL/CentOS 6 ##
#RUN     rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Default programs
RUN     yum install -y openssh-server openssh-clients passwd git unzip bzip2 ruby-full rubygems tar

# SSH access
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
#RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
#RUN sed -ri 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN sed -ri 's/#PermitEmptyPasswords no/PasswordAuthentication yes/g' /etc/ssh/sshd_config && echo 'root:admin' | chpasswd

# Install sass/compass
RUN gem install sass
RUN gem install compass

# Install Node.js and npm
RUN 	yum install -y nodejs --enablerepo=epel
RUN		curl -L http://npmjs.org/install.sh | clean=no sh

# install supervisord
RUN yum install -y python-pip && pip install pip --upgrade
RUN pip install supervisor
ADD supervisord.conf /etc/

# Create a user, because yeoman / bower get into troubles with root user
RUN /usr/sbin/useradd --home-dir /usr/local --shell /bin/bash user
RUN chown -R user /usr && chmod -R 777 /usr/
RUN echo 'user:user' | chpasswd && passwd -f -u user

# Install Yo stack
RUN npm install -g yo generator-angular generator-webapp

RUN /usr/sbin/useradd --create-home --shell /bin/bash vagrant
RUN mkdir -p /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant: /home/vagrant/.ssh
RUN echo -n 'vagrant:vagrant' | chpasswd
RUN touch /home/vagrant/.hushlogin

EXPOSE  22 8080 9000 9001
CMD ["supervisord", "-n"]

#docker rm -f `docker ps --no-trunc -aq` && docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi -f
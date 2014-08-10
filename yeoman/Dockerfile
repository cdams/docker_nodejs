FROM    cdams/nodejs:centos7
MAINTAINER Damien <cdams@outlook.fr>

# Avoid the question at the yeoman first run
RUN mkdir -p /.config/configstore /.local /.cache
RUN chown -R user /.npm /usr/lib /.config /.local /.cache

# Install Yo stack
RUN npm install -g yo generator-angular generator-webapp generator-symfony #--no-bin-links

USER user
WORKDIR /home/user

CMD ["webapp --skip-install"]
ENTRYPOINT ["yo"]
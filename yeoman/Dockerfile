FROM    cdams/nodejs
MAINTAINER Damien <cdams@outlook.fr>

# Install Yo stack
RUN npm install -g generator-angular generator-webapp generator-symfony #--no-bin-links

# Avoid the question at the yeoman first run
RUN mkdir -p /.config/configstore /.local /.cache
RUN chown -R user /.npm /usr/lib /.config /.local /.cache

USER user
WORKDIR /home/user

CMD ["--skip-install"]
ENTRYPOINT ["yo"]
FROM    cdams/nodejs
MAINTAINER Damien <cdams@outlook.fr>

USER user
WORKDIR /home/user

EXPOSE 9000 9001

CMD mkdir -p /tmp/node_modules && rm -rf /home/user/node_modules && ln -s /tmp/node_modules/ /home/user/node_modules && bower install --quiet && npm install && grunt serve --allow-remote
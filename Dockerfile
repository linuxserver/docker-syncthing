FROM linuxserver/baseimage
MAINTAINER Your Name <your@email.com>

#Applying stuff
RUN curl -s https://syncthing.net/release-key.txt | sudo apt-key add - && \
echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list && \
apt-get update -q && install syncthing && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*


#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh


# Volumes and Ports
VOLUME /config
EXPOSE 8384

## NOTES ##
## Delete files\folders not needed, e.g. if you dont run any cron commands, delete the cron folder and the "ADD cron/ /etc/cron.d/" line. 
## The User abc, should be running everything, give that permission in any case you need it. 
## Use linuxserver/baseimage as often as posible (or linuxserver/baseimage.nginx where applicable)
## When creating init's Use 10's where posible, its to allow add stuff in between when needed. also, do not be afraid to split custom code into several little ones. 
## Make stuff as quiet as posible "e.g. apt-get update -qq" (Does not apply to the "app" itself. e.g. plex)
## user abc and folders /app /config /defaults are all created by baseimage
FROM linuxserver/baseimage
MAINTAINER lonix <lonixx@gmail.com>
ENV APTLIST="syncthing"

#Applying stuff
RUN curl -s https://syncthing.net/release-key.txt | apt-key add - && \
echo deb http://apt.syncthing.net/ syncthing release | tee /etc/apt/sources.list.d/syncthing-release.list && \
apt-get update -q && \
apt-get install -qy $APTLIST && \

# give abc home folder of /config
usermod -d /config abc && \

# clean up
apt-get clean && \
rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Volumes and Ports
VOLUME ["/config", "/sync"]
EXPOSE 8384

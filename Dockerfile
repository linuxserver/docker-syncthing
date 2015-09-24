FROM linuxserver/baseimage
MAINTAINER lonix <lonixx@gmail.com>
ENV APTLIST="syncthing"

#Applying stuff
RUN curl -s https://syncthing.net/release-key.txt | apt-key add - && \
echo deb http://apt.syncthing.net/ syncthing release | tee /etc/apt/sources.list.d/syncthing-release.list && \
apt-get update -q && apt-get install -y $APTLIST && \
usermod -d /config abc && \
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh

# Volumes and Ports
VOLUME ["/config", "/sync"]
EXPOSE 8384
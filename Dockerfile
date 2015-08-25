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
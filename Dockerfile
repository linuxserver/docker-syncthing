FROM lsiobase/alpine
MAINTAINER sparklyballs

# environment settings
ENV HOME="/config"

# install packages
RUN \
 apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community \
	syncthing

# add local files
COPY root/ /

# ports and volumes
VOLUME ["/config", "/sync"]
EXPOSE 8384 22000 21027/UDP

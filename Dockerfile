FROM lsiobase/alpine
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment settings
ENV HOME="/config"

# install packages
RUN \
 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/community \
	syncthing \
	syncthing-utils

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8384 22000 21027/UDP
VOLUME /config /sync

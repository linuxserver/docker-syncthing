FROM lsiobase/alpine:3.6
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment settings
ARG SYNC_SRC="/tmp/syncthing"
ARG SYNC_BUILD="$SYNC_SRC/src/github.com/syncthing/syncthing"
ENV HOME="/config"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	g++ \
	gcc \
	go \
	tar && \

# compile syncthing
 mkdir -p \
	"${SYNC_BUILD}" && \
 export GOPATH="${SYNC_SRC}" && \
 SYNC_TAG=$(curl -sX GET "https://api.github.com/repos/syncthing/syncthing/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/syncthing-src.tar.gz -L \
	"https://github.com/syncthing/syncthing/archive/${SYNC_TAG}.tar.gz" && \
 tar xf \
 /tmp/syncthing-src.tar.gz -C \
	"${SYNC_BUILD}" --strip-components=1 && \
 cd "${SYNC_BUILD}" && \
 go run build.go -no-upgrade -version=${SYNC_TAG} && \

# install syncthing
 install -d -o abc -g abc \
	/var/lib/syncthing && \
 install -D -m755 \
	$SYNC_BUILD/bin/syncthing \
	/usr/bin/syncthing && \
 for i in $(ls $SYNC_BUILD/bin); \
	do if ! [ "$i" = "syncthing" ]; \
	then install -Dm 755 $SYNC_BUILD/bin/$i /usr/bin/$i ; \
	fi; \
 done && \
 export GOPATH="" && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8384 22000 21027/UDP
VOLUME /config /sync

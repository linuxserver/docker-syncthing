FROM lsiobase/alpine
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment settings
ENV HOME="/config"

# set build and source folders
ARG SYNC_SRC="/tmp/syncthing"
ARG SYNC_BUILD="$SYNC_SRC/src/github.com/syncthing"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	go \
	tar && \

# compile syncthing
 SYNC_TAG=$(curl -sX GET "https://api.github.com/repos/syncthing/syncthing/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 mkdir -p \
	"${SYNC_BUILD}" \
	"${SYNC_SRC}" && \
 curl -o \
 /tmp/syncthing.tar.gz -L \
	"https://github.com/syncthing/syncthing/archive/${SYNC_TAG}.tar.gz" && \
 tar xf \
 /tmp/syncthing.tar.gz -C \
	"${SYNC_SRC}" --strip-components=1 && \
 ln -s "$SYNC_SRC" "$SYNC_BUILD/syncthing" && \
 cd "$SYNC_BUILD"/syncthing && \
 export GOPATH="${SYNC_SRC}" && \
 go run build.go -no-upgrade -version=${SYNC_TAG} && \

# install syncthing
 install -d -o abc -g abc \
	/var/lib/syncthing && \
 install -D -m755 \
	$SYNC_BUILD/syncthing/bin/syncthing \
	/usr/bin/syncthing && \
 for i in $(ls $SYNC_BUILD/syncthing/bin); \
	do if ! [ "$i" = "syncthing" ]; \
	then install -Dm 755 $SYNC_BUILD/syncthing/bin/$i /usr/bin/$i ; \
	fi; \
 done && \
 export GOPATH="" && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8384 22000 21027/UDP
VOLUME /config /sync

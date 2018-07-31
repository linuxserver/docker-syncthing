FROM lsiobase/alpine:3.7 as buildstage
# specifically using 3.7 alpine in buildstage
# cgo bug in 1.10x go
# runtime stage uses 3.8 alpine

# build variables
ARG SYNC_SRC="/tmp/syncthing"
ARG SYNC_BUILD="$SYNC_SRC/src/github.com/syncthing/syncthing"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	curl \
	g++ \
	gcc \
	go \
	tar

RUN \
echo "**** fetch source code ****" && \
 mkdir -p \
	"${SYNC_BUILD}" && \
 SYNC_TAG=$(curl -sX GET "https://api.github.com/repos/syncthing/syncthing/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/syncthing-src.tar.gz -L \
	"https://github.com/syncthing/syncthing/archive/${SYNC_TAG}.tar.gz" && \
 tar xf \
 /tmp/syncthing-src.tar.gz -C \
	"${SYNC_BUILD}" --strip-components=1 && \
 echo "**** compile syncthing  ****" && \
 cd "${SYNC_BUILD}" && \
 export GOPATH="${SYNC_SRC}" && \
 go run build.go -no-upgrade -version=${SYNC_TAG} && \
 echo "**** install syncthing to tmp folder ****" && \
 mkdir -p \
	/tmp/bin && \
 install -D -m755 \
	$SYNC_BUILD/bin/syncthing \
	/tmp/bin/syncthing && \
 for i in $(ls $SYNC_BUILD/bin); \
	do if ! [ "$i" = "syncthing" ]; \
	then install -Dm 755 $SYNC_BUILD/bin/$i /tmp/bin/$i ; \
	fi; \
 done

############## runtime stage ##############
FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ENV HOME="/config"

RUN \
 echo "**** create var lib folder ****" && \
 install -d -o abc -g abc \
	/var/lib/syncthing

# copy files from build stage and local files
COPY --from=buildstage /tmp/bin/ /usr/bin/
COPY root/ /

# ports and volumes
EXPOSE 8384 22000 21027/UDP
VOLUME /config /sync

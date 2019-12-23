FROM lsiobase/alpine:3.11 as buildstage

# build variables
ARG SYNCTHING_RELEASE

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	curl \
	g++ \
	gcc \
	git \
	go \
	tar

RUN \
echo "**** fetch source code ****" && \
 if [ -z ${SYNCTHING_RELEASE+x} ]; then \
	SYNCTHING_RELEASE=$(curl -sX GET "https://api.github.com/repos/syncthing/syncthing/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 mkdir -p \
	/tmp/sync && \
 curl -o \
 /tmp/syncthing-src.tar.gz -L \
	"https://github.com/syncthing/syncthing/archive/${SYNCTHING_RELEASE}.tar.gz" && \
 tar xf \
 /tmp/syncthing-src.tar.gz -C \
	/tmp/sync --strip-components=1 && \
 echo "**** compile syncthing  ****" && \
 cd /tmp/sync && \
 rm -f go.sum && \
 go clean -modcache && \
 CGO_ENABLED=0 go run build.go \
	-no-upgrade \
	-version=${SYNCTHING_RELEASE} \
	build syncthing

############## runtime stage ##############
FROM lsiobase/alpine:3.11

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# environment settings
ENV HOME="/config"

RUN \
 echo "**** create var lib folder ****" && \
 install -d -o abc -g abc \
	/var/lib/syncthing

# copy files from build stage and local files
COPY --from=buildstage /tmp/sync/syncthing /usr/bin/
COPY root/ /

# ports and volumes
EXPOSE 8384 22000 21027/UDP
VOLUME /config

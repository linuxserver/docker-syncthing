[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# [linuxserver/syncthing](https://github.com/linuxserver/docker-syncthing)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/syncthing.svg)](https://microbadger.com/images/linuxserver/syncthing "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/syncthing.svg)](https://microbadger.com/images/linuxserver/syncthing "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/syncthing.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/syncthing.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-syncthing/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-syncthing/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/syncthing/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/syncthing/latest/index.html)

[Syncthing](https://syncthing.net) replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet.

[![syncthing](https://syncthing.net/images/logo-horizontal.svg)](https://syncthing.net)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/syncthing` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=syncthing \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e UMASK_SET=<022> \
  -p 8384:8384 \
  -p 22000:22000 \
  -p 21027/udp:21027/udp \
  -v </path/to/appdata/config>:/config \
  -v </path/to/data1>:/data1 \
  -v </path/to/data2>:/data2 \
  --restart unless-stopped \
  linuxserver/syncthing
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  syncthing:
    image: linuxserver/syncthing
    container_name: syncthing
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - UMASK_SET=<022>
    volumes:
      - </path/to/appdata/config>:/config
      - </path/to/data1>:/data1
      - </path/to/data2>:/data2
    ports:
      - 8384:8384
      - 22000:22000
      - 21027/udp:21027/udp
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8384` | Application WebUI |
| `-p 22000` | Listening port |
| `-p 21027/udp` | Protocol discovery |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e UMASK_SET=<022>` | Umask setting - [explaination](https://askubuntu.com/questions/44542/what-is-umask-and-how-does-it-work) |
| `-v /config` | Configuration files. |
| `-v /data1` | Data1 |
| `-v /data2` | Data2 |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

**Note: ** The Syncthing devs highly suggest setting a password for this container as it listens on 0.0.0.0. To do this go to `Actions -> Settings -> set user/password` for the webUI.


## Support Info

* Shell access whilst the container is running: `docker exec -it syncthing /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f syncthing`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' syncthing`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/syncthing`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/syncthing`
* Stop the running container: `docker stop syncthing`
* Delete the container: `docker rm syncthing`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start syncthing`
* You can also remove the old dangling images: `docker image prune`

### Via Taisun auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one shot:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock taisun/updater \
  --oneshot syncthing
  ```
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull syncthing`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d syncthing`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **22.02.19:** - Rebasing to alpine 3.9.
* **16.01.19:** - Add pipeline logic and multi arch.
* **30.07.18:** - Rebase to alpine 3.8 and use buildstage.
* **13.12.17:** - Rebase to alpine 3.7.
* **25.10.17:** - Add env for manual setting of umask.
* **29.07.17:** - Simplify build structure as symlinks failing on > 0.14.32
* **28.05.17:** - Rebase to alpine 3.6.
* **08.02.17:** - Rebase to alpine 3.5.
* **01.11.16:** - Switch to compiling latest version from git source.
* **14.10.16:** - Add version layer information.
* **30.09.16:** - Fix umask.
* **09.09.16:** - Add layer badges to README.
* **28.08.16:** - Add badges to README.
* **11.08.16:** - Rebase to alpine linux.
* **18.12.15:** - Initial testing / release (IronicBadger)
* **24.09.15:** - Inital dev complete (Lonix)

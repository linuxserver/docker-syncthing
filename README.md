[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://syncthing.net
[hub]: https://hub.docker.com/r/linuxserver/syncthing/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/syncthing
[![](https://images.microbadger.com/badges/version/linuxserver/syncthing.svg)](https://microbadger.com/images/linuxserver/syncthing "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/syncthing.svg)](https://microbadger.com/images/linuxserver/syncthing "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/syncthing.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/syncthing.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-syncthing)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-syncthing/)

Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet.

You can find some of the best documentation available on the web at [docs.syncthing.net](http://docs.syncthing.net/).

[![syncthing](https://syncthing.net/images/logo-horizontal.svg)][appurl]

## Usage

```
docker create \
  --name=syncthing \
  -v *host path to config*:/config \
  -v *host path to data*:/mnt/any/dir/you/want \
  -e PGID=<gid> -e PUID=<uid>  \
  -e UMASK_SET=<022> \
  -p 8384:8384 -p 22000:22000 -p 21027:21027/udp \
  linuxserver/syncthing
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-v /config` - This contains configuration to keep it static, as well as a default shared directory
* `-v /mnt/dir` - Add multiple folders to allow Syncthing access to data you wish to sync
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e UMASK_SET` for umask setting , *optional* , default if left unset is 022. 
* `-p 8384` Webui Port
* `-p 22000` Listening Port
* `-p 21027/udp` Discovery Port

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it syncthing /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

You can find some of the best documentation available on the web at [docs.syncthing.net](http://docs.syncthing.net/).

**Note: ** The Syncthing devs highly suggest setting a password for this container as it listens on 0.0.0.0. To do this go to `Actions -> Settings -> set user\password` for the webUI.

## Info

* Shell access whilst the container is running: `docker exec -it syncthing /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f syncthing`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' syncthing`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/syncthing`

## Versions

+ **30.07.18:** Rebase to alpine 3.8 and use buildstage.
+ **13.12.17:** Rebase to alpine 3.7.
+ **25.10.17:** Add env for manual setting of umask.
+ **29.07.17:** Simplify build structure as symlinks failing on > 0.14.32
+ **28.05.17:** Rebase to alpine 3.6.
+ **08.02.17:** Rebase to alpine 3.5.
+ **01.11.16:** Switch to compiling latest version from git source.
+ **14.10.16:** Add version layer information.
+ **30.09.16:** Fix umask. 
+ **09.09.16:** Add layer badges to README. 
+ **28.08.16:** Add badges to README. 
+ **11.08.16:** Rebase to alpine linux. 
+ **18.12.15:** Initial testing / release (IronicBadger)
+ **24.09.15:** Inital dev complete (Lonix)

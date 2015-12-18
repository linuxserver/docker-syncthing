![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another container release featuring auto-update on startup, easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](http://forum.linuxserver.io) 
* [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`

# linuxserver/syncthing

![https://syncthing.net](https://syncthing.net/images/logo-horizontal.svg)

Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet.

You can find some of the best documentation available on the web at [docs.syncthing.net](http://docs.syncthing.net/).

## Usage

```
docker create \
  --name=syncthing \
  --net=host
  -v *path to config*:/config \
  -v *path to data*:/mnt/any/dir/you/want \
  -e PGID=1001 -e PUID=1001  \
  -p 8384:8384 \
  linuxserver/syncthing
```

**Parameters**

* `--net=host` - allows Syncthing to communicate over the network (required)
* `-v /config` - This contain configuration to keep it static, as well as a default shared directory
* `-v /mnt/dir` - Add multiple folders to allow Syncthing access to data you wish to sync
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `genent passwd` as below:

	getent passwd | grep dockeruser
    dockeruser:x:1001:1001:,,,:/home/dockeruser

## Setting up the application

You can find some of the best documentation available on the web at [docs.syncthing.net](http://docs.syncthing.net/).

## Misc

* Shell access whilst the container is running: `docker exec -it syncthing /bin/bash`
* Upgrade to the latest version: `docker restart syncthing`
* To monitor the logs of the container in realtime: `docker logs -f syncthing`

## Versions

+ **18.12.2015:** Initial testing / release (IronicBadger)
+ **24.09.2015:** Inital dev complete

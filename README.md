![https://linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io](https://forum.linuxserver.io)
* [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`

# linuxserver/syncthing

![https://syncthing.net](https://syncthing.net/images/logo-horizontal.svg)

Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet.

You can find some of the best documentation available on the web at [docs.syncthing.net](http://docs.syncthing.net/).

## Usage

```
docker create \
  --name=syncthing \
  -v *host path to config*:/config \
  -v *host path to data*:/mnt/any/dir/you/want \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8384:8384 -p 22000:22000 -p 21027:21027/udp \
  linuxserver/syncthing
```

**Parameters**

* `-v /config` - This contain configuration to keep it static, as well as a default shared directory
* `-v /mnt/dir` - Add multiple folders to allow Syncthing access to data you wish to sync
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-p 8384` Webui Port
* `-p 22000` Listening Port
* `-p 21027/udp` Discovery Port

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" <sup>TM</sup>.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `genent passwd` as below:

	getent passwd | grep dockeruser
    dockeruser:x:1001:1001:,,,:/home/dockeruser

## Setting up the application

You can find some of the best documentation available on the web at [docs.syncthing.net](http://docs.syncthing.net/).

**Note: ** The Syncthing devs highly suggest setting a password for this container as it listens on 0.0.0.0. To do this go to `Actions -> Settings -> set user\password` for the webUI.

## Misc

* Shell access whilst the container is running: `docker exec -it syncthing /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f syncthing`

## Versions

+ **02.07.16:** Rebase to alpine for smaller image size. 
+ **18.12.15:** Initial testing / release (IronicBadger)
+ **24.09.15:** Inital dev complete (Lonix)

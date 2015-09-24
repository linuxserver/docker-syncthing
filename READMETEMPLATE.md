![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/syncthing

![https://syncthing.net](https://syncthing.net/images/logo-horizontal.svg)

Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet.

## Usage

```
docker create --name=syncthing -v /etc/localtime:/etc/localtime:ro -v <path to data>:/config -e PGID=<gid> -e PUID=<uid>  -p 8384:8384 linuxserver/syncthing
```

**Parameters**

* `-p 8384` - the port(s)
* `-v /etc/localhost` for timesync - *optional*
* `-v /config` - This contain configuration to keep it static, aswell as a default shared directory 
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it syncthing /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

Browse to http://<server-ip>:8384 and follow the wizard


## Updates

* Upgrade to the latest version simply `docker restart syncthing`.
* To monitor the logs of the container in realtime `docker logs -f syncthing`.



## Versions

+ **24.09.2015:** Inital Release. 

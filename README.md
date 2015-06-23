TeamSpeak
=========

TeamSpeak - http://www.teamspeak.com/

Latest stable Teamspeak from Arch Linux AUR using Packer to compile.

Fork form binhex/arch-teamspeak

**Pull image**

```
docker pull kahatie/arch-teamspeak
```

**Run container**

```
docker run -d --net="host" --name=<container name> -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro kahatie/arch-teamspeak
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

Connect using TeamSpeak client with the following details

```
<host ip>:9987
```

To authenticate use the privilege key shown in the logs using the following command

```
docker logs <container name>
```

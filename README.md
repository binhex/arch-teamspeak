TeamSpeak
=========

TeamSpeak - http://www.teamspeak.com/

Latest stable Teamspeak from Arch Linux AUR using Packer to compile.

**Pull image**

```
docker pull binhex/arch-teamspeak
```

**Run container**

```
docker run -d --net="host" --name=<container name> -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-teamspeak
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
Connect using TeamSpeak client on host ip with port 9987
```
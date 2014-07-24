Teamspeak
=========

Teamspeak - http://www.teamspeak.com/

Latest stable Teamspeak from Arch Linux AUR using Packer to compile.

**Pull image**

```
docker pull binhex/arch-teamspeak
```

**Run container**

```
docker run -d -p 9987:9987 -p 30033:30033 -p 10011:10011 --name=<container name> -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-teamspeak
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
Connect using Teamspeak client on port 9987
```
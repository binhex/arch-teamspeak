**Application**

[TeamSpeak3](http://www.teamspeak.com/)

**Description**

TeamSpeak is proprietary voice-over-Internet Protocol (VoIP) software that allows computer users to speak on a chat channel with fellow computer users, much like a telephone conference call. A TeamSpeak user will often wear a headset with an integrated microphone. Users use the TeamSpeak client software to connect to a TeamSpeak server of their choice, from there they can join chat channels and discuss things.

**Build notes**

Latest stable TeamSpeak release from Arch Linux AUR.

**Usage**
```
docker run -d \
    --net="host" \
    --name=<container name> \
    -v <path for config files>:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=<umask for created files> \
    -e PUID=<uid for user> \
    -e PGID=<gid for user> \
    binhex/arch-teamspeak
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

Connect using the TeamSpeak client on `<host ip>:9987`

**Example**
```
docker run -d \
    --net="host" \
    --name=teamspeak \
    -v /apps/docker/teamspeak:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=000 \
    -e PUID=0 \
    -e PGID=0 \
    binhex/arch-teamspeak
```

**Notes**

User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:-

```
id <username>
```

To authenticate use the privileged key shown in /config/supervisord.log
___
If you appreciate my work, then please consider buying me a beer  :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MM5E27UX6AUU4)

[Documentation](https://github.com/binhex/documentation) | [Support forum](http://lime-technology.com/forum/index.php?topic=45849.0)
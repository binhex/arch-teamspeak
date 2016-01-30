**Application**

[TeamSpeakl](http://www.teamspeak.com/)

**Application description**

TeamSpeak is proprietary voice-over-Internet Protocol (VoIP) software that allows computer users to speak on a chat channel with fellow computer users, much like a telephone conference call. A TeamSpeak user will often wear a headset with an integrated microphone. Users use the TeamSpeak client software to connect to a TeamSpeak server of their choice, from there they can join chat channels and discuss things.

**Build notes**

Latest stable TeamSpeak release from Arch Linux AUR using Packer to compile.

**Usage**
```
docker run -d \
	--net="host" \
	--name=<container name> \
	-v <path for config files>:/config \
	-v /etc/localtime:/etc/localtime:ro \
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
	binhex/arch-teamspeak
```

**Notes**

To authenticate use the privileged key shown in /config/supervisord.log

[Support forum](http://lime-technology.com/forum/index.php?topic=45849.0)
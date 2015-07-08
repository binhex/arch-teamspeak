#!/bin/bash

# exit script if return code != 0
set -e

# install pre-reqs
pacman -Sy --noconfirm

# call aur packer script
source /root/packer.sh

# set permissions
chown -R nobody:users /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/
chmod -R 775 /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*

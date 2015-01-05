FROM binhex/arch-base:2015010500
MAINTAINER binhex

# additional files
##################

# add teamspeak script for application (custom script required to cd to sql lib)
ADD teamspeak.sh /usr/bin/teamspeak.sh
RUN chmod +x /usr/bin/teamspeak.sh

# add supervisor conf file for app
ADD teamspeak.conf /etc/supervisor/conf.d/teamspeak.conf

# install app
#############

# install base devel, install app using packer, set perms, cleanup
RUN pacman -Sy --noconfirm && \
	pacman -S --needed base-devel --noconfirm && \
	useradd -m -g wheel -s /bin/bash makepkg-user && \
	echo -e "makepkg-password\nmakepkg-password" | passwd makepkg-user && \
	echo "%wheel      ALL=(ALL) ALL" >> /etc/sudoers && \
	echo "Defaults:makepkg-user      !authenticate" >> /etc/sudoers && \
	curl -o /home/makepkg-user/packer.tar.gz https://aur.archlinux.org/packages/pa/packer/packer.tar.gz && \
	cd /home/makepkg-user && \
	tar -xvf packer.tar.gz && \
	su -c "cd /home/makepkg-user/packer && makepkg -s --noconfirm --needed" - makepkg-user && \
	pacman -U /home/makepkg-user/packer/packer*.tar.xz --noconfirm && \
	su -c "packer -S teamspeak3-server --noconfirm" - makepkg-user && \
	chown -R nobody:users /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/ && \
	chmod -R 775 /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/ && \	
	pacman -Ru packer base-devel git --noconfirm && \
	yes|pacman -Scc && \
	userdel -r makepkg-user && \
	rm -rf /usr/share/locale/* && \
	rm -rf /usr/share/man/* && \
	rm -rf /root/* && \
	rm -rf /tmp/*

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
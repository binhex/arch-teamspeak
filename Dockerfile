FROM binhex/arch-base:2014101300
MAINTAINER binhex

# additional files
##################

# download packer from aur
ADD https://aur.archlinux.org/packages/pa/packer/packer.tar.gz /root/packer.tar.gz

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
	cd /root && \
	tar -xzf packer.tar.gz && \
	cd /root/packer && \
	makepkg -s --asroot --noconfirm && \
	pacman -U /root/packer/packer*.tar.xz --noconfirm && \
	packer -S teamspeak3-server --noconfirm && \
	pacman -Ru base-devel --noconfirm && \
	pacman -Scc --noconfirm && \
	chown -R nobody:users /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/ && \
	chmod -R 775 /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/ && \	
	rm -rf /archlinux/usr/share/locale && \
	rm -rf /archlinux/usr/share/man && \
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
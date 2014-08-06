FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases for arch
RUN pacman -Sy --noconfirm

# run packer to install application
RUN packer -S teamspeak3-server --noconfirm

# required for nobody user to find sql scripts
RUN cd /usr/share/teamspeak3-server/sql/

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# expose default voice port (udp)
EXPOSE 9987/udp

# expose file transfer port
EXPOSE 30033

# expose query port
EXPOSE 10011

# set permissions
#################

# change owner
RUN chown -R nobody:users /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/

# set permissions
RUN chmod -R 775 /usr/bin/teamspeak3-server /usr/share/teamspeak3-server/sql/ /var/lib/teamspeak3-server/

# cleanup
#########

# completely empty pacman cache folder
RUN pacman -Scc --noconfirm

# remove temporary files
RUN rm -rf /tmp/*

# run supervisor
################

# add supervisor file for application
ADD teamspeak.conf /etc/supervisor/conf.d/teamspeak.conf

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]

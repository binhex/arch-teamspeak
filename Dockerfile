FROM binhex/arch-base:2015030300
MAINTAINER binhex

# additional files
##################

# add supervisor conf file for app
ADD *.conf /etc/supervisor/conf.d/

# add teamspeak script for application (custom script required to cd to sql lib)
ADD start.sh /home/nobody/start.sh

# add install bash script
ADD install.sh /root/install.sh

# add packer bash script
ADD packer.sh /root/packer.sh

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
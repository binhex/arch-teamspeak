#!/bin/bash
# startup script for teamspeak

# change dir to sql files
cd /usr/share/teamspeak3-server/sql/

# run teamspeak server
/usr/bin/teamspeak3-server logpath=/config dbsqlpath=/usr/share/teamspeak3-server/sql/
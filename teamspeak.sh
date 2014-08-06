#!/bin/bash
# startup script for teamspeak

# change dir to sql files
cd /usr/share/teamspeak3-server/sql/

# run teamspeak server
/usr/bin/teamspeak3-server default_voice_port=9987 filetransfer_port=30033 query_port=10011 logpath=/config dbsqlpath=/usr/share/teamspeak3-server/sql/
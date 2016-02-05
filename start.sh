#!/bin/bash

# create variables for installation path of teamspeak
install_path="/usr/share/teamspeak3-server"

# create variables for db path in docker container
db_path="$install_path/sql/ts3server.sqlitedb"

# if db DOES NOT exist in docker container and db DOES exist on /config then symlink to db
if [ ! -f $db_path ] && [ -f /config/ts3server.sqlitedb ]
then
    ln -s /config/ts3server.sqlitedb $db_path
fi

# if db DOES exist in docker container and DOES NOT exist on /config then move to /config and symlink to db on /config
if [ -f $db_path ] && [ ! -f /config/ts3server.sqlitedb ]
then
    mv $db_path /config/ts3server.sqlitedb
    ln -s /config/ts3server.sqlitedb $db_path
fi

# if db DOES exist in docker container and DOES exist on /config then delete db in container and symlink to db on /config
if [ -f $db_path ] && [ -f /config/ts3server.sqlitedb ]
then
    rm $db_path
    ln -s /config/ts3server.sqlitedb $db_path
fi

# change dir to sql files
cd /usr/share/teamspeak3-server/sql/

# run teamspeak server
/usr/bin/ts3server logpath=/config dbsqlpath=/usr/share/teamspeak3-server/sql/ licensepath=/config

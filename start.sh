#!/bin/bash

# create variables for installation path of teamspeak
install_path="/usr/share/teamspeak3-server"

# create variables for db path in docker container
db_path="$install_path/sql/ts3server.sqlitedb"

# create variables for files path in docker container
files_path="$install_path/sql/files"

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

### FILES ###
# same for files folder used for files transfet

# if files DOES NOT exist in docker container and files DOES exist on /config then symlink to files
if [ ! -d $files_path ] && [ -d /config/files ]
then
    ln -s /config/files $files_path
fi

# if files DOES exist in docker container and DOES NOT exist on /config then move to /config and symlink to files on /config
if [ -d $files_path ] && [ ! -d /config/files ]
then
    mv $files_path /config/files
    ln -s /config/files $files_path
fi

# if files DOES exist in docker container and DOES exist on /config then delete files in container and symlink to files on /config
if [ -d $files_path ] && [ -d /config/files ]
then
    rm -rf $files_path
    ln -s /config/files $files_path
fi


# change dir to sql files
cd /usr/share/teamspeak3-server/sql/

# run teamspeak server
/usr/bin/teamspeak3-server logpath=/config dbsqlpath=/usr/share/teamspeak3-server/sql/ licensepath=/config

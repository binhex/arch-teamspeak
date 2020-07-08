#!/bin/bash

# create variables for installation path of teamspeak
install_path="/usr/share/teamspeak3-server"

# create variables for location of config file on /config
teamspeak_config="/config/teamspeak/config/ts3server.ini"

# create variables for location of default config file
teamspeak_default_config="/home/nobody/ts3server.ini"

# create variable for path that stores the virtual server
virtualserver_container="${install_path}/sql/files"

# create variable for path that stores the virtual server
virtualserver_config="/config/sql/files"

# create variables for db path in docker container
sqlitedb_container="${install_path}/sql/ts3server.sqlitedb"

# create variables for db path on /config
sqlitedb_config="/config/sql/ts3server.sqlitedb"

# if teamspeak sqlitedb file doesnt exist in /config/sql/ then copy default and symlink back (soft linked)
if [ ! -f "${sqlitedb_config}" ]; then

	echo "[info] teamspeak sqlitedb file doesnt exist, copying default to '${sqlitedb_config}'..."

	mkdir -p "/config/sql"

	# if teamspeak sqlitedb file exists in container then rename
	if [[ -f "sqlitedb_container" && ! -L "sqlitedb_container" ]]; then
		mv "${sqlitedb_container}" "${sqlitedb_container}-backup"
		cp "${sqlitedb_container}-backup" "${sqlitedb_config}"
	fi

else

	echo "[info] teamspeak sqlitedb file already exists, skipping copy"

fi

# create soft link to sqlite db file
ln -fs "${sqlitedb_config}" "${sqlitedb_container}"

# if teamspeak virtual server folder doesnt exist on /config then copy default and symlink back (soft linked)
if [ ! -d "${virtualserver_config}" ]; then

	echo "[info] teamspeak virtual server folder doesnt exist, copying default to '${virtualserver_config}'..."

	mkdir -p "${virtualserver_config}"

	# if teamspeak virtual server folder exists in container then rename
	if [[ -d "virtualserver_container" && ! -L "virtualserver_container" ]]; then
		mv "${virtualserver_container}" "${virtualserver_container}-backup"
		cp -R "${virtualserver_container}-backup" "${virtualserver_config}"
	fi

else

	echo "[info] teamspeak virtual server folder already exists, skipping copy"

fi

# create soft link to virtual server folder
ln -fs "${virtualserver_config}" "${virtualserver_container}"

# if teamspeak config file doesnt exist in /config/teamspeak/config/ then copy default
if [ ! -f "${teamspeak_config}" ]; then

	echo "[info] teamspeak config file doesnt exist, copying default to '${teamspeak_config}'..."
	mkdir -p "/config/teamspeak/config"

	cp "${teamspeak_default_config}" "${teamspeak_config}"

fi

# run teamspeak server
mkdir -p /config/teamspeak/logs /config/teamspeak/license /config/teamspeak/lists
cd "${install_path}/sql/" && /usr/bin/ts3server inifile="${teamspeak_config}" license_accepted=1

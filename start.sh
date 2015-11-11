#!/usr/bin/env bash
if [ ! -f /srv/couchpotato/config/config.ini ]; then
	#generate the config file for the first time using docker-gen

	cheetah fill --oext cfg --env /srv/couchpotato/config/couchpotato
fi

/usr/bin/python /srv/couchpotato/app/CouchPotato.py \
	--data_dir /srv/couchpotato/data \
	--config_file /srv/couchpotato/config/couchpotato.cfg
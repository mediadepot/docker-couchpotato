#!/usr/bin/env bash
if [ ! -f /srv/couchpotato/config/couchpotato.cfg ]; then
	#generate the config file for the first time using conf.d

	confd -onetime -backend rancher -prefix /2015-07-25
	chown -R depot:depot /srv/couchpotato
fi

su -c "/usr/bin/python /srv/couchpotato/app/CouchPotato.py --data_dir /srv/couchpotato/data --config_file /srv/couchpotato/config/couchpotato.cfg" depot

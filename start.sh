#!/usr/bin/env sh

#run the default config script
sh /srv/config.sh

#chown the couchpotato directory by the new user
chown mediadepot:mediadepot -R /srv/couchpotato

# download the latest version of CouchPotato
su -c "git clone https://github.com/RuudBurger/CouchPotatoServer.git /srv/couchpotato/app" mediadepot

# run CouchPotato
su -c "/usr/bin/python /srv/couchpotato/app/CouchPotato.py --data_dir /srv/couchpotato/data --config_file /srv/couchpotato/config/couchpotato.cfg" mediadepot

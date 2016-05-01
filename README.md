# Requirements


# Environmental
The following environmental variables must be populated, when running container 

- PUID
- PGID

# Ports
The following ports must be mapped, when running container 

 - 5050 #webui listen 
 
# Volumes
The following volumes must be mapped, when running container 

- /srv/couchpotato/config
- /srv/couchpotato/data
- /mnt/movies:/mnt/movies
- /mnt/downloads/[Movies]:/mnt/downloads
- /mnt/blackhole/[Movies]:/mnt/blackhole

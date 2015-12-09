# Requirements


# Environmental
The following environmental variables must be populated, when running container 

- DEPOT_USER,
- DEPOT_PASSWORD
- COUCHPOTATO_API_KEY
- PUSHOVER_USER_KEY

# Ports
The following ports must be mapped, when running container 

 - 8080 #webui listen 
 
# Volumes
The following volumes must be mapped, when running container 

- /srv/couchpotato/config
- /srv/couchpotato/data
- /mnt/movies
- /mnt/downloads/[Movies]:/mnt/downloads
- /mnt/blackhole/[Movies]:/mnt/blackhole

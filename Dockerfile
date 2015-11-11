FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Create internal depot user (which will be mapped to external DEPOT_USER, with the uid and gid values)
RUN groupadd -g 15000 -r depot && useradd --uid 15000 -r -g depot depot

#Install base applications + deps
RUN echo "deb http://http.us.debian.org/debian stable main contrib non-free" | tee -a /etc/apt/sources.list
RUN apt-get -q update && \
    apt-get install -qy --force-yes python-cheetah python-openssl python-pip build-essential python-dev libffi-dev libssl-dev unrar curl && \
    pip install --upgrade cryptography pyopenssl ndg-httpsclient pyasn1 && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create couchpotato folder structure & set as volumes
RUN mkdir -p /srv/couchpotato/app && \
	mkdir -p /srv/couchpotato/config && \
	mkdir -p /srv/couchpotato/data


#Install Couchpotato
RUN git clone https://github.com/RuudBurger/CouchPotatoServer.git /srv/couchpotato/app


#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh
ADD ./template/couchpotato.tmpl /srv/couchpotato/config/couchpotato.tmpl

VOLUME ["/srv/couchpotato/app", "/srv/couchpotato/config", "/srv/couchpotato/data"]

EXPOSE 8081

CMD ["/srv/start.sh"]
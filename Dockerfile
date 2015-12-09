FROM debian:jessie
MAINTAINER jason@thesparktree.com

#Create internal depot user (which will be mapped to external DEPOT_USER, with the uid and gid values)
RUN groupadd -g 15000 -r depot && useradd --uid 15000 -r -g depot depot

#Install base applications + deps
RUN echo "deb http://http.us.debian.org/debian stable main contrib non-free" | tee -a /etc/apt/sources.list
RUN apt-get -q update && \
    apt-get install -qy --force-yes git-core libffi-dev libssl-dev python python-cherrypy python-dev python-lxml python-pip python-cheetah unrar unzip curl && \
    pip install pyopenssl ndg-httpsclient && \
    apt-get -y autoremove  && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create confd folder structure
RUN curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-linux-amd64
RUN chmod u+x  /usr/local/bin/confd
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates

#Create couchpotato folder structure & set as volumes
RUN mkdir -p /srv/couchpotato/app && \
	mkdir -p /srv/couchpotato/config && \
	mkdir -p /srv/couchpotato/data


#Install Couchpotato
RUN git clone https://github.com/RuudBurger/CouchPotatoServer.git /srv/couchpotato/app


#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

VOLUME ["/srv/couchpotato/app", "/srv/couchpotato/config", "/srv/couchpotato/data"]

EXPOSE 8080

CMD ["/srv/start.sh"]
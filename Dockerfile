FROM debian:jessie
MAINTAINER avinash.s@yukthi.com

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install python-ldap
RUN apt-get -y install python-apt
RUN apt-get -y install ldap-utils
RUN apt-get -y install python-smbpasswd
RUN apt-get -y install python-psycopg2
RUN apt-get -y install python-cracklib
RUN apt-get -y install python-flask
# Only because we need the schema
RUN echo "slapd   slapd/no_configuration  boolean true" | debconf-set-selections
RUN apt-get -y install slapd slapd-smbk5pwd

# Install Apache
RUN apt-get -y install apache2 libapache2-mod-wsgi
RUN apt-get -y install python-daemon

RUN apt-get -y install nodejs
RUN apt-get -y install npm
RUN ln -s /usr/bin/nodejs /usr/local/bin/node
RUN npm install -g brunch@1.8.5 bower foreman
RUN apt-get -y install git

RUN sed -i s/Listen\ 443/Listen\ 443\\n\ \ \ \ Listen\ 7080/ /etc/apache2/ports.conf

RUN a2enmod ssl
RUN a2ensite default-ssl

# Cleanup
RUN apt-get clean

RUN adduser --home /var/lib/totaloffice --system --group --gecos "TotalOffice Account,,," --shell /bin/sh totaloffice

COPY run-totaloffice /
ENTRYPOINT /run-totaloffice

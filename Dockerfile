FROM debian:jessie
MAINTAINER avinash.s@yukthi.com

ADD apt/backports.list /etc/apt/sources.list.d/
ADD apt/totaloffice.list /etc/apt/sources.list.d/
ADD apt/priority /etc/apt/preferences.d/
ADD sudoers/totaloffice /etc/sudoers.d/

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install python-ldap
RUN apt-get -y install python-apt
RUN apt-get -y install ldap-utils
RUN apt-get -y install python-smbpasswd
RUN apt-get -y install python-psycopg2
RUN apt-get -y install python-cracklib
RUN apt-get -y install python-flask
RUN apt-get --force-yes -y install python-pumpkin
# Only because we need the schema
RUN echo "slapd   slapd/no_configuration  boolean true" | debconf-set-selections
RUN apt-get -y install slapd slapd-smbk5pwd
RUN mkdir /var/lib/totaloffice
COPY run-totaloffice /
ENTRYPOINT /run-totaloffice

FROM debian:latest
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
RUN apt-get -y install salt-common sudo python-msgpack
RUN apt-get --force-yes -y install python-pumpkin
RUN mkdir /var/lib/totaloffice
RUN salt-call --local sys.doc apt
RUN apt-get -y install python-daemon
COPY run-totaloffice /
ENTRYPOINT /run-totaloffice

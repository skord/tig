FROM ubuntu:14.04
RUN apt-get update
ADD https://s3.amazonaws.com/influxdb/influxdb_0.9.6.1_amd64.deb /influxdb_0.9.6.1_amd64.deb
RUN dpkg -i influxdb_0.9.6.1_amd64.deb
ADD influxdb.conf /etc/influxdb/influxdb.conf
ADD startup.sh /startup.sh
RUN chmod +x /startup.sh
VOLUME /var/lib/influxdb
CMD /startup.sh

#!/bin/bash

set -m

PIDFILE=/var/run/influxdb.pid
exec /usr/bin/influxd -config /etc/influxdb/influxdb.conf 

if [ ! -e /var/lib/influxdb/boostrapped ]; then
  echo "Initializing InfluxDB"
  while [[ RET -ne 0 ]]; do
    echo "Waiting for influxdb"
    sleep 3
    curl -k http://`hostname`:8086/ping 2> /dev/null
    RET=$?
  done
  if [ -z "${INFLUXDB_DATABASE}" ]; then
    echo "Creating DB"
    /usr/bin/influx -execute "CREATE DATABASE ${INFLUXDB_DATABASE}"
    if [-z "${INFLUXDB_USER} -a -z "${INFLUXDB_PASSWORD}]; then
      /usr/bin/influx -execute "CREATE USER ${INFLUXDB_USER} WITH PASSWORD '${INFLUXDB_PASSWORD}'"
      /usr/bin/influx -exexcute "GRANT ALL ON ${INFLUXDB_DATABASE} to ${INFLUXDB_USER}"
    fi
  fi
  if [ -z "${INFLUXDB_ADMIN_USER}" -a -z "${INFLUXDB_ADMIN_PASSWORD}" ]; then
    echo "Creating User and Password"
    /usr/bin/influx -execute "CREATE USER ${INFLUXDB_ADMIN_USER} WITH PASSWORD '${INFLUXDB_ADMIN_PASSWORD}' WITH ALL PRIVILEGES"
    sed -ri "s/auth-enabled = false/auth-enabled = true/" /etc/influxdb/influxdb.conf
  fi
  touch /var/lib/influxdb/bootstrapped
  kill -HUP 1
fi


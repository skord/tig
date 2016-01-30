#!/bin/sh

set -e


sed -ri "s/# username = \"telegraf\"/username = \"${INFLUXDB_USER}\"/" /etc/telegraf/telegraf.conf
sed -ri "s/# password = \"metricsmetricsmetricsmetrics\"/password = \"${INFLUXDB_PASSWORD}\"/" /etc/telegraf/telegraf.conf
sed -ri "s/database = \"telegraf\"/database = \"${INFLUXDB_DATABASE}\"/" /etc/telegraf/telegraf.conf
sed -ri "s/influxdb:8086/${INFLUXDB_PORT_8088_TCP_ADDR}:${INFLUXDB_PORT_8086_TCP_PORT}/" /etc/telegraf/telegraf.conf

exec /go/src/github.com/influxdata/telegraf/telegraf -config /etc/telegraf/telegraf.conf

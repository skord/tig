FROM golang:1.5.3-alpine
RUN apk update && apk add git && apk add make
RUN go get github.com/influxdata/telegraf
WORKDIR /go/src/github.com/influxdata/telegraf
RUN make
ENV PATH /go/src/github.com/influxdata/telegraf:$PATH
RUN mkdir -p /etc/telegraf
ADD telegraf.conf /etc/telegraf/telegraf.conf
ADD startup.sh /startup.sh
RUN chmod +x /startup.sh
CMD ["/startup.sh"]

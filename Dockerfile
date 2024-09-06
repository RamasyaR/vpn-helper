FROM alpine:latest

LABEL maintainer="Raman Rakavets <radikot88@gmail.com>"

RUN apk add --update iptables bash

ADD bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

CMD ["vpn-helper-run"]

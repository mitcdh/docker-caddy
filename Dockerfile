FROM alpine:latest
MAINTAINER Mitchell Hewes <me@mitcdh.com>

ENV CADDY_FEATURES="http.git,http.prometheus,http.realip"

COPY files/run.sh /caddy-bootstrap/run.sh

RUN apk --update add \
	curl \
	openssh-client \
	git \
	tar \
	ca-certificates \
	shadow \
 && curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${CADDY_FEATURES}&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && mkdir /caddy-bootstrap/pre-run/ \
 && rm -rf /var/cache/apk/*

WORKDIR /www
ENTRYPOINT ["/caddy-bootstrap/run.sh"]

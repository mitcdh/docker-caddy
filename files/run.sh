#!/bin/sh

# pre-run scripts
chmod 500 /caddy-bootstrap/pre-run/* 
run-parts --exit-on-error /caddy-bootstrap/pre-run/ || exit $?

# generate our caddyfile from provided head
IFS=$'\n'
cat /caddy-bootstrap/Caddyfile > /www/Caddyfile
echo "$*" >> /www/Caddyfile

# exec caddy as web-srv from a clean login shell
exec su -s /bin/sh -c "exec caddy" - web-srv

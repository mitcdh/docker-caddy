#!/bin/sh
IFS=$'\n'
echo "$*" >> /www/Caddyfile
exec su -s /bin/sh -c "exec caddy" - web-srv

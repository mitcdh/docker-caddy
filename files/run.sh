#!/bin/sh
IFS=$'\n'
cat /scripts/Caddyfile > /www/Caddyfile
echo "$*" >> /www/Caddyfile
exec su -s /bin/sh -c "exec caddy" - web-srv

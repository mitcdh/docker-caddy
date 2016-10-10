#!/bin/sh

cat >>/www/Caddyfile
exec su -s /bin/sh -c "exec caddy" - web-srv

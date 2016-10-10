#!/bin/sh

echo $"$*" >> /www/Caddyfile
exec su -s /bin/sh -c "exec caddy" - web-srv

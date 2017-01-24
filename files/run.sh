#!/bin/sh

# pre-run scripts
run-parts --exit-on-error /caddy-bootstrap/pre-run/ || exit $?

# generate our caddyfile from provided head
if [ -e "/caddy-bootstrap/Caddyfile" ]; then
	echo "config check: found head caddyfile"
	cat /caddy-bootstrap/Caddyfile > /www/Caddyfile
fi

IFS=$'\n'
echo "$*" >> /www/Caddyfile

# exec caddy as www-data from a clean login shell
exec su -s /bin/sh -c "exec caddy" - www-data

#!/bin/sh

DATADIR="/www"
PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Create a group for our gid if required
if ! getent group www-data >/dev/null; then
	echo "creating www-data group for gid ${PGID}"
	groupadd --gid ${PGID} --non-unique www-data >/dev/null 2>&1
fi

# Create a user for our uid if required
if ! getent passwd www-data >/dev/null; then
	echo "creating www-data user for uid ${PUID}"
	useradd --gid ${PGID} --non-unique --comment "Web Server" \
	 --home-dir "${DATADIR}" --create-home \
	 --uid ${PUID} www-data >/dev/null 2>&1

	echo "taking ownership of /www for www-data"
	chown ${PUID}:${PGID} "${DATADIR}"
fi


# pre-run scripts
run-parts --exit-on-error /caddy-bootstrap/pre-run/ || exit $?

# generate our caddyfile from provided head
if [ -e "/caddy-bootstrap/Caddyfile" ]; then
	echo "config check: found head caddyfile"
	cat /caddy-bootstrap/Caddyfile > /www/Caddyfile
fi

IFS=$'\n'
echo "$*" >> /www/Caddyfile

ACME_AGREE=true

# exec caddy as www-data from a clean login shell
exec su -s /bin/sh -c "exec caddy --agree" - www-data

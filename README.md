# Docker Caddy Server

Docker base image for a Caddy web server running on [AlpineLinux](http://alpinelinux.org).

Includes the git, prometheus, and realip features. Merges a Caddyfile from /scripts/Caddyfile and args on boot and exec's caddy as a `web-srv` user.

### Usage
#### Base web server Extended with Prometheus and RealIP
````bash
docker pull mitcdh/caddy "prometheus" "realip {" "from 10.42.0.0/16" "from 172.17.0.0/16" "}"
````

### Structure
* `/www`: Web root
* `/scripts/Caddyfile`: Base caddyfile

### Exposed Ports
* `2015`: http web server

### Credits
* [abiosoft](https://github.com/abiosoft) for [caddy-docker](https://github.com/abiosoft/caddy-docker) which the caddy curl was based on.

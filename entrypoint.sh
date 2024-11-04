#!/bin/sh

openrc default

rc-update add nix-daemon default

rc-service nix-daemon start

# exec nix-shell /app/

exec "$@"
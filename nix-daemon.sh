#!/sbin/openrc-run
description="Nix multi-user support daemon"

command="/usr/sbin/nix-daemon"
command_background="yes"
pidfile="/run/$RC_SVCNAME.pid"

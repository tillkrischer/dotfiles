#!/usr/bin/env bash

# handle being called from systemd service
if [ -z "$XDG_RUNTIME_DIR" ] && [ -z "$SWAYSOCK"]; then
	uid=$(id -u $USER)
	export XDG_RUNTIME_DIR="/run/user/"$uid"/"
	export SWAYSOCK=$(find $XDG_RUNTIME_DIR -iname sway*sock)
fi

swaylock -i $(/home/till/bin/wallpaper)

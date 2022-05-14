#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

CONF=""
MONITORS=$(xrandr --listactivemonitors | grep 'Monitors:' | cut -d' ' -f2)

case $MONITORS in
	1)
		CONF="one.ini"
	;;
	2)
		CONF="two.ini"
	;;
	*)
		echo "No configuration found for current number of monitors"
		exit 1
	;;
esac

echo "Working..."

dconf dump /org/mate/panel/ > "backups/$(date +"%Y%m%d_%H%M").ini"

mate-panel --reset
sleep 2
dconf load /org/mate/panel/ < $CONF

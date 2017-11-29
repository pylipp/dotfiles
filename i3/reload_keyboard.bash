#! /bin/bash

# setxkbmap resets the keyboard layout if the keyboard is un/replugged
# This script (started by i3) periodically checks the layout and updates it if necessary

if [[ ! -e /usr/share/X11/xkb/symbols/pylipp ]]; then
    exit 0
fi

while true; do
    if [[ "$(echo $(setxkbmap -query | grep layout | awk '{ print $2; }'))" != "pylipp" ]]; then
        setxkbmap pylipp -option caps:escape
    fi

    sleep 5
done
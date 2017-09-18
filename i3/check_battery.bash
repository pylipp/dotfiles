#! /bin/bash

# Utility script to issue a warning at low battery level (<15%).

while true; do
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)

    # display notification for 14 seconds and sleep for 15 to avoid overlap
    if [[ $capacity -lt 15 ]]; then
        notify-send -t 14000 -u critical WARNING "Remaining battery level: $capacity% !!"
    fi

    sleep 15
done

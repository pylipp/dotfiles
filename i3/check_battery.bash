#! /bin/bash

# Utility script to issue a warning at low battery level (<15%) and eventually
# shutdown the machine at a level <10%.

if [[ $(pgrep -f "$0" | grep -c -v $$) -gt 1 ]]; then
    # abort if another process already running
    exit 1
fi

while true; do
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    status_=$(cat /sys/class/power_supply/BAT0/status)

    if [[ $status_ = "Discharging" ]]; then
        # display notification for 14 seconds and sleep for 15 to avoid overlap
        if [[ $capacity -lt 30 ]]; then
            notify-send -t 14000 -u critical WARNING "Remaining battery level: $capacity% !!"
        fi
        if [[ $capacity -lt 10 ]]; then
            notify-send -u critical WARNING "Low battery, powering off..."
            sleep 3
            systemctl poweroff
        fi
    fi

    sleep 10
done

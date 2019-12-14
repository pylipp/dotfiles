#!/usr/bin/env bash

# Average CPU core temperature in m°C for i3status
OUTPUT=/tmp/core_temperature

if [[ $(pgrep -f "$0" | grep -c -v $$) -gt 1 ]]; then
    # abort if another process already running
    exit 1
fi

# Same logic as in psutil.sensors_temperature()
INPUT_DIR=/sys/class/hwmon/hwmon0

if [[ -d $INPUT_DIR ]]; then
    while true; do
        cat $INPUT_DIR/temp*_input | awk '{ sum += $1 } END { if (NR > 0) print sum / NR }' > $OUTPUT
        sleep 5
    done
fi

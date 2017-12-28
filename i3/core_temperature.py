#! /usr/bin/python3

import psutil
import time
import os.path
import sys

filepath = "/tmp/core_temperature"
if os.path.exists(filepath):
    raise SystemExit("{} exists, assuming that another process is running. "
               "Aborting.".format(filepath))

while True:
    with open(filepath, "w") as f:
        temperature = psutil.sensors_temperatures()['coretemp'][0].current
        print(int(temperature * 1000), file=f)
    time.sleep(0.5)
done

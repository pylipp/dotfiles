#! /usr/bin/python3

import psutil
import time

while True:
    with open("/tmp/core_temperature", "w") as f:
        temperature = psutil.sensors_temperatures()['coretemp'][0].current
        print(int(temperature * 1000), file=f)
    time.sleep(0.5)
done

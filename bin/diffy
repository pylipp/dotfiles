#!/bin/bash

if command -v delta > /dev/null 2>&1; then
    exec delta "$@"
else
    exec less -RFX
fi

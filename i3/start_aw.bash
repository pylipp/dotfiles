#!/bin/bash

if [[ -d ~/software/activitywatch ]]; then
    cd ~/software/activitywatch
    ./aw-server &
    ./aw-watcher-afk &
    ./aw-watcher-window &
    cd
fi

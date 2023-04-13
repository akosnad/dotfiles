#!/bin/bash

# if wofi is running, close it
if [ $(pgrep wofi) ]; then
    killall wofi
# if not running, launch it
else
    exec wofi --show drun,run
fi


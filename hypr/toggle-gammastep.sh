#!/bin/bash

state="$(systemctl is-active --user gammastep)"

# if gammastep service is running, stop it

if [[ "$state" == "deactivating" ]]; then
    exit 0
fi

if [[ "$state" == "active" ]]; then
    notify-send -t 3000 -e 'Gammastep' 'Gammastep is now disabled'
    systemctl --user stop gammastep
# if not running, start it
else
    systemctl --user start gammastep
    notify-send -t 3000 -e 'Gammastep' 'Gammastep is now enabled'
fi

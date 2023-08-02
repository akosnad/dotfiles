#!/bin/bash

# put your monitor configs here
asus="ASUS VN247"

function name_to_connection() {
    name="$1"
    connection="$(hyprctl monitors -j | jq -r ".[] | select(.description | match(\"${name}\")) | .name")"
    echo "$connection"
}

function connected() {
    monitor="$1"

    if [[ "$monitor" == "$(name_to_connection "$asus")" ]]; then
        hyprctl keyword monitor "${monitor},preferred,0x0,1"
        hyprctl keyword monitor "${primary},preferred,192x1080,1"
    fi
}

function disconnected() {
    # monitor="$1"

    hyprctl keyword monitor "${primary},preferred,auto,1"
}

###########

primary="$(hyprctl monitors -j | jq -r '.[0].name')"

exec 4< <( \
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - \
    | stdbuf -o0 grep '^monitoradded>>' \
)

while read -r line; do
    monitor="$(echo $line | sed 's/^monitoradded>>//')"
    echo "connected $monitor"
    connected $monitor
done <&4 &


exec 5< <(socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - \
    | stdbuf -o0 grep '^monitorremoved>>' \
)

while read -r line; do
    monitor="$(echo $line | sed 's/^monitorremoved>>//')"
    echo "disconnected $monitor"
    disconnected $monitor
done <&5 &

wait $(jobs -p)

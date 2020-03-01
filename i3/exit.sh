#!/bin/bash

msg="exit i3
cancel"
r=$(echo "${msg}" | rofi -dmenu -lines 2)

if [ "$r" == 'exit i3' ]; then
	i3-msg exit
fi
exit 0

#!/bin/sh
systemctl --user stop hyprland-session.service
hyprctl dispatch exit

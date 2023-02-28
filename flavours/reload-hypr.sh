#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme Adwaita
sleep 0.2
gsettings set org.gnome.desktop.interface gtk-theme FlatColor

eww reload || eww open bar

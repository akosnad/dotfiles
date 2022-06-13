#!/bin/bash
set -e

## this must be run as the greeter user

export $(dbus-launch)
gsettings set org.gnome.desktop.interface gtk-theme FlatColor


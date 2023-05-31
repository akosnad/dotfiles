#!/bin/bash

yay -S --needed waydroid waydroid-script-git sway swaybg
sudo waydroid init -s GAPPS
sudo systemctl enable --now waydroid-container

sudo install -m 755 -o root -g root ./waydroid-launch /usr/local/bin
sudo mkdir -p /etc/waydroid
sudo install -m 644 -o root -g root ./sway-config /etc/waydroid/sway-config
sudo install -m 755 -o root -g root ./*.sh /etc/waydroid/

w="waydroid-launch"
envs="/etc/greetd/environments"

if ! [ -d "$(dirname $envs)" ]; then
    sudo mkdir -p "$(dirname $envs)"
fi
filter=$(echo $w | sed 's/\-/\\\-/g')
if ! grep -q "$filter" "$envs" >/dev/null 2>&1; then
    sudo sh -c "echo $w >> $envs"
fi

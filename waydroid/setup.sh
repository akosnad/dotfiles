#!/bin/bash

yay -S --needed waydroid waydroid-script-git sway swaybg
sudo waydroid init -s GAPPS
sudo systemctl enable --now waydroid-container

sudo install -m 755 -o root -g root ./waydroid-launch /usr/local/bin
sudo mkdir -p /etc/waydroid
sudo install -m 644 -o root -g root ./sway-config /etc/waydroid/sway-config
sudo install -m 755 -o root -g root ./*.sh /etc/waydroid/

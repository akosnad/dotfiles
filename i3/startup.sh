#!/bin/bash
set -e

if [[ $(optimus-manager --print-mode | grep -oP '(?<=: ).*$') == "nvidia" ]]; then
	mons -S 9,10:R
	xrandr --output VGA-1 --mode 1440x900 --rate 75
	xrandr --output HDMI-1 --mode 1920x1080 --rate 72
else
	mons -S 0,1:R
	xrandr --output VGA-1 --mode 1440x900 --rate 75
	xrandr --output HDMI-1 --mode 1920x1080 --rate 72
fi
xset dpms 0 0 300
xset r rate 150 50
xinput set-prop 'USB OPTICAL MOUSE' 'libinput Accel Speed' -0.75
systemctl --user start loggedin.target
systemctl --user start xfce4-notifyd.service
picom -b --config $HOME/dotfiles/picom/picom.conf
$HOME/dotfiles/polybar/start.sh
$HOME/.fehbg

redshift-gtk &
powerkit &

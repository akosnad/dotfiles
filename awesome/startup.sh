#!/bin/bash
set -e

mons -S 0,6:R
mons --primary HDMI-0
xrandr --output DVI-I-0 --mode 1440x900 --rate 75
xrandr --output HDMI-0 --mode 1920x1080 --rate 74

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

xset dpms 0 0 300
xset +dpms
xset r rate 150 50
xset +fp ~/dotfiles/fonts/

xinput set-prop 'USB OPTICAL MOUSE' 'libinput Accel Speed' -0.75
setxkbmap -layout 'us,hu' -option "grp:caps_toggle"
xmodmap -e "clear lock"

xdg_menu --format awesome --root-menu /etc/xdg/menus/manjaro-applications.menu > ~/dotfiles/awesome/archmenu.lua

picom -b --config $HOME/dotfiles/picom/picom.conf
$HOME/.fehbg


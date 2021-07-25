#!/bin/bash
set -e

export XDG_CONFIG_HOME="$HOME/.config"

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

xset dpms 0 0 300
xset +dpms
xset r rate 150 50
xset +fp ~/dotfiles/fonts/

xinput set-prop 'pointer:Logitech G305' 'libinput Accel Speed' -0.8
setxkbmap -layout 'us,hu' -option "grp:caps_toggle"
xmodmap -e "clear lock"

xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu > ~/dotfiles/awesome/archmenu.lua

picom -b --config $HOME/dotfiles/picom/picom.conf
$HOME/.fehbg


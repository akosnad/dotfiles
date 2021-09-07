#!/bin/bash
#set -e

export XDG_CONFIG_HOME="$HOME/.config"

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

xset dpms 0 0 300
xset +dpms
xset r rate 150 50
xset +fp ~/dotfiles/fonts/

# xinput set-prop 'pointer:Logitech G305' 'libinput Accel Speed' -0.8
for id in $(xinput --list | sed -n '/.*pointer/s/.*=\([0-9]\+\).*/\1/p')
do
    xinput set-prop $id "libinput Accel Speed" -0.8
done

setxkbmap -layout 'us,hu' -option "grp:caps_toggle"
xmodmap -e "clear lock"

picom -b --experimental-backend --config $HOME/dotfiles/picom/picom.conf
$HOME/.fehbg


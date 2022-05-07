#!/bin/bash
#set -e

export XDG_CONFIG_HOME="$HOME/.config"

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

xset dpms 0 0 300
xset +dpms
xset r rate 150 50
xset +fp ~/dotfiles/fonts/

setxkbmap -layout 'us,hu' -option "grp:caps_toggle"
xmodmap -e "clear lock"

if [ ! -f $HOME/dotfiles/awesome/.no-compositor ]; then
    picom -b --experimental-backend --config $HOME/dotfiles/picom/picom.conf
fi

if [ -f $HOME/.fehbg ]; then
    $HOME/.fehbg
fi

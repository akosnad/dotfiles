#!/bin/bash
set -e

# arg 1: theme (relative) file name
# arg 2: icon base style name
gen_theme() {
    oomox-cli -m all "$HOME/dotfiles/oomox/$1"
    /opt/oomox/plugins/icons_$2/change_color.sh "$HOME/dotfiles/oomox/$1"
}

gen_theme onedark-darker papirus

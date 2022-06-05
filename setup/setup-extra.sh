#!/bin/bash
set -e
source "helpers.sh"

setup_dependency full

### Packages
verify_packages "$setup_dir/packages-extra"

### Discord
running_before=$(if (pidof Discord &>/dev/null); then echo 1; fi)
if [[ $(betterdiscordctl status | grep "injected: no") ]]; then
    betterdiscordctl install
fi
/usr/bin/discord </dev/null &>/dev/null &
mkdir -p "$HOME/.config/beautifuldiscord"
beautifuldiscord --css "$HOME/.config/beautifuldiscord/style.css" &>/dev/null
if [[ ! $running_before == "1" ]]; then killall -INT Discord &>/dev/null; fi

setup_done extra

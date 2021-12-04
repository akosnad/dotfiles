#!/bin/bash
#set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"

# arg 1: text to include
# arg 2: file to check in or to create
function include_text() {
    if ! grep -q "$1" "$2" >/dev/null 2>&1; then
        echo $1 >> $2
    fi
}

# arg 1: name of file which is a list of packages to install
function verify_packages() {
    rm .installed .to-install
    yay -Qn > .installed # we put it in a file, so we don't call it every loop, very slow otherwise :/
    yay -Qm >> .installed
    while read p; do
        if ! grep -P "^$p\ .*$" .installed >/dev/null 2>&1; then
            if ! grep -P "^$p\ .*$" .installed >/dev/null 2>&1; then
                echo "$p" >> .to-install
            fi
        fi
    done < $1
    if [ -f .to-install ]; then
        yay -S --noconfirm --quiet --needed --nocleanmenu --noeditmenu --nodiffmenu $(awk '$1=$1' ORS=' ' .to-install)
        rm .to-install
    fi
    rm .installed
}

# arg 1: name of file which is a table of links and targets
function setup_symlinks() {
    while read -u 3 line; do
        source="$HOME/$(echo $line | sed "s/\:.*$//")"
        dest="$dotfiles/$(echo $line | sed "s/^.*\://")"
        if [ ! -L "$source" ]; then
            if [ -f "$source" ]; then
                read -p "$source exists, and is not a symlink, replace it? (y/n) " reply
                if [ "$reply" == "y" ]; then
                    rm "$source"
                else
                    continue
                fi
            fi
            mkdir -p "$(dirname "$source")"
            ln -s "$dest" "$source"
        fi
    done 3<$1
}

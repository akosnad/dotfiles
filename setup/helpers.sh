#!/bin/bash
#set -e
setup_dir="$(dirname $(realpath $BASH_SOURCE))"
dotfiles="$(realpath $setup_dir/..)"

# arg 1: text to include
# arg 2: file to check in or to create
function include_text() {
    if ! grep -q "$1" "$2" >/dev/null 2>&1; then
        echo $1 >> $2
    fi
}

# arg 1: name of file which is a list of packages to install
function verify_packages() {
    yay -S --noconfirm --quiet --needed --nocleanmenu --noeditmenu --nodiffmenu $(awk '$1=$1' ORS=' ' $1) |& { grep -vE "there is nothing to do|--\s*skipping" || true; }
}

# arg 1: name of file which is a table of links and targets
function setup_symlinks() {
    while read -u 3 line; do
        source="$HOME/$(echo $line | sed "s/\:.*$//")"
        dest="$dotfiles/$(echo $line | sed "s/^.*\://")"
        if [ ! -L "$source" ]; then
            if [ -f "$source" ] || [ -d "$source" ]; then
                read -p "$source exists, and is not a symlink, replace it? (y/n) " reply
                if [ "$reply" == "y" ]; then
                    rm -r "$source"
                else
                    continue
                fi
            fi
            mkdir -p "$(dirname "$source")"
            ln -s "$dest" "$source"
        fi
    done 3<$1
}

# arg 1: setup name
if [[ "$@" == *"--as-dependency" ]]; then
    function setup_done() { echo -n ''; }
else
    function setup_done() {
        printf "\n\n$1 setup complete\n"
        echo "$(realpath "setup-$1.sh")" > $dotfiles/.last-config
    }
fi

# arg 1: setup name
function setup_dependency() {
    $setup_dir/setup-$1.sh --as-dependency
}

function get_configs() {
    pushd $dotfiles &>/dev/null
    find setup -name "setup-*.sh" | sed 's/^setup\/setup-//;s/.sh$//'
    popd &>/dev/null
}

function get_last_setup_name() {
    cat $dotfiles/.last-config | sed 's/^.*setup\-//;s/.sh$//'
}

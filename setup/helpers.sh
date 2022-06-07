#!/bin/bash
#set -e
if ! declare -F "__setup_helper_sourced" &>/dev/null; then
    function __setup_helper_sourced() { echo -n ''; }
else
    echo asdasdasd &>/dev/null # for some reason, without this, bash doesn't skip properly
    return
fi

setup_dir="$(dirname $(realpath $BASH_SOURCE))"
dotfiles="$(realpath $setup_dir/..)"

function get_current_setup_name() {
    caller 1 | awk '{print $3}' | sed 's/^.*setup\-//;s/.sh$//'
}
parent_setup_name="$(get_current_setup_name)"

packages_to_install=""
links_to_link=""
setup_dependencies=""
if [ -f "packages-$parent_setup_name" ]; then
    packages_to_install="$(awk '$1=$1' ORS=' ' packages-$parent_setup_name)"
fi
if [ -f "links-$parent_setup_name" ]; then
    links_to_link="$(printf '%s\n%s' "$(cat links-$parent_setup_name)")"
fi
__dep="$(grep -E "^setup_dependency" setup-$parent_setup_name.sh | awk '{print $2}')"
if [[ "$__dep" != "" ]]; then
    setup_dependencies="$__dep"
fi

# arg 1: text to include
# arg 2: file to check in or to create
function include_text() {
    if ! grep -q "$1" "$2" >/dev/null 2>&1; then
        echo $1 >> $2
    fi
}

function install_packages() {
    yay -S --noconfirm --quiet --needed --nocleanmenu --noeditmenu --nodiffmenu $packages_to_install |& { grep -vE "there is nothing to do|--\s*skipping" || true; }
}

function setup_symlinks() {
    for line in ${links_to_link[@]}; do
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
    done
}

__deps_set_up=0
# arg 1: setup name
function setup_dependency() {
    if (( $__deps_set_up == 1 )); then return; fi

    if [ -f "packages-$1" ]; then
        packages_to_install="$(awk '$1=$1' ORS=' ' packages-$1)$packages_to_install"
    fi
    if [ -f "links-$1" ]; then
        links_to_link="$(printf '%s\n%s' "$(cat links-$1)" "$links_to_link")"
    fi
    # printf "packages:\n%s\n\n\n" "$packages_to_install"
    # printf "links:\n%s\n\n\n" "$links_to_link"
    # echo "$@"

    # source $setup_dir/setup-$1.sh --as-dependency
    dep="$(grep -E "^setup_dependency" setup-$1.sh | awk '{print $2}' )"
    if [[ "$dep" != "" ]]; then
        setup_dependencies="$(printf '%s %s' "$dep" "$setup_dependencies")"
        setup_dependency $dep
    fi

    if [[ "$(get_current_setup_name)" == "$parent_setup_name" ]]; then
        # reached end of dependencies, we are running in the parent setup now
        install_packages
        setup_symlinks

        __deps_set_up=1
        for c in ${setup_dependencies[@]}; do
            source $setup_dir/setup-$c.sh --as-dependency
        done
        echo "$parent_setup_name" > $dotfiles/.last-config
    fi

}
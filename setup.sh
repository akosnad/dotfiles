#!/bin/bash
set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
setup_dir="$(realpath $dotfiles/setup)"

function get_configs() {
    find setup -name "setup-*.sh" | sed 's/^setup\/setup-//;s/.sh$//'
}

function get_last_setup_name() {
    cat $dotfiles/.last-config
}

configs=($(get_configs))

if [[ "$@" == *"-f" ]]; then
    rm -f $dotfiles/.last-config
fi

if ! [ -f "$dotfiles/.last-config" ]; then
    printf "Please select a configuration you would like to use:\n"
    printf "(You can change it later by adding the -f flag to this script)\n"
    for (( i=0; i<${#configs[@]}; i++ )); do
        printf "%s:\t%s\n" "$i" "${configs[$i]}"
    done

    while true; do
        read reply
        if (( $reply<${#configs[@]} && $reply >=0 )); then
            printf "Running %s config...\n" "${configs[$reply]}"
            cd $setup_dir
            ./setup-${configs[$reply]}.sh
            break
        fi
        printf "Please enter a valid choice between 0 and %s: " "$((( ${#configs[@]} - 1 )))"
    done
else
    printf "Running %s config...\n" $(get_last_setup_name)
    cd $setup_dir
    ./setup-$(cat $dotfiles/.last-config).sh
fi

printf "\n\nDone setting up %s config\n" "$(get_last_setup_name)"

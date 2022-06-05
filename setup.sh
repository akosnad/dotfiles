#!/bin/bash
set -e
source "./setup/helpers.sh"

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
        printf "Running %s setup...\n" "${configs[$reply]}"
        cd $setup_dir
        ./setup-${configs[$reply]}.sh
        break
    fi
    printf "Please enter a valid choice between 0 and %s: " "$((( ${#configs[@]} - 1 )))"
    done
else
    printf "Running %s setup...\n" $(get_last_setup_name)
    cd $setup_dir
    $(cat $dotfiles/.last-config)
fi


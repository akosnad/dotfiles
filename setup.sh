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

function run_config() {
    printf "Running %s config...\n" $1
    cd $setup_dir
    ./setup-"$1".sh
}

function prompt_setup_name() {
    printf "Please select a configuration you would like to use:\n" 1>&2
    printf "(You can change it later by adding the -f flag to this script)\n" 1>&2
    for (( i=0; i<${#configs[@]}; i++ )); do
        printf "%s:\t%s\n" "$i" "${configs[$i]}" 1>&2
    done

    while true; do
        read reply
        if (( $reply<${#configs[@]} && $reply >=0 )); then
            echo ${configs[$reply]}
            return
        fi
        printf "Please enter a valid choice between 0 and %s: " "$((( ${#configs[@]} - 1 )))" 1>&2
    done
}

configs=($(get_configs))

if [[ "$@" == *"-f" ]]; then
    rm -f $dotfiles/.last-config
fi

if ! [ -f "$dotfiles/.last-config" ]; then
    run_config $(prompt_setup_name)
else
    run_config $(get_last_setup_name)
fi

printf "\n\nDone setting up %s config\n" "$(get_last_setup_name)"

#!/bin/bash

current=$(flavours current)
echo current: $current

function get_light_variant() {
    list=$(flavours list | tr ' ' '\n')
    if [[ $current =~ .*-dark-? ]]; then
        target=$(echo $current | sed 's/-dark/-light/')
        if [[ $list =~ .*${target}.* ]]; then
            echo $target
            return
        fi
    else
    for i in $list; do
        if [[ $i =~ .*${current}.*-light-? ]]; then
            echo $i
            return
        fi
    done
    fi
}

function get_dark_variant() {
    list=$(flavours list | tr ' ' '\n')
    nonlight=$(echo $current | sed 's/-light//')
    dark=$(echo $current | sed 's/-light/-dark/')

    for i in $list; do
        if [[ $i =~ .*${dark}.* ]]; then
            echo $dark
            return
        elif [[ $i =~ .*${nonlight}.* ]]; then
            echo $nonlight
            return
        fi
    done
}

if [[ $current =~ -light-? ]]; then
    variant=$(get_dark_variant)
else
    variant=$(get_light_variant)
fi

if [[ "$variant" != "" ]]; then
    echo applying: $variant
    flavours apply $variant
else
    echo no opposite variant found
    exit 1
fi

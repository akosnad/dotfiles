#!/bin/bash
set -e

for rp in $(find templates -maxdepth 1 -type d ! -path templates); do
    ap="$(readlink --canonicalize $rp)"
    p="$(echo $rp | sed 's/^templates\///g')"
    l="$HOME/.local/share/flavours/base16/templates/$p"
    if [ ! -L $l ]; then
        ln -s $ap $l
    fi
done

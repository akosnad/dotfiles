#!/bin/bash
set -e

for s in $(find . -maxdepth 1 -type f ! -name link_services.sh); do
    ap="$(readlink --canonicalize $s)"
    p="$(echo $s | sed 's/^[\.\/]*//')"
    l="$HOME/.config/systemd/user/$p"
    if [ ! -L $l ]; then
        ln -s $ap $l
    fi
done

#!/bin/bash
set -e
source "helpers.sh"

setup_dependency minimal

source wayland.sh

### Dunst
pushd $dotfiles/dunst
./generate.sh
popd

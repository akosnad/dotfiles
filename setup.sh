#!/bin/bash
#set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

$dotfiles/setup-minimal.sh

### Packages
verify_packages "$dotfiles/packages"

### Xresources
include_text "#include \"$dotfiles/Xresources\"" "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources"

### Config file symlinks
setup_symlinks "$dotfiles/links"

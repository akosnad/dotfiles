#!/bin/bash
set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

$dotfiles/setup-minimal.sh

### Packages
verify_packages "$dotfiles/packages"

### Xresources
include_text "#include \"$dotfiles/Xresources\"" "$HOME/.Xresources"
mkdir -p "$HOME/.Xresources.d"
include_text "#include \".Xresources.d/colors\"" "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources"

### GTK
if [ ! -d "$HOME/.themes/FlatColor" ]; then
    git clone "https://github.com/jasperro/FlatColor" "$HOME/.themes/FlatColor"
fi
if ! egrep -q "^include \"../colors2\"$" "$HOME/.themes/FlatColor/gtk-2.0/gtkrc"; then
    pushd "$HOME/.themes/FlatColor" >/dev/null
    git apply "$dotfiles/gtk/flatcolor.patch"
    popd >/dev/null
fi


### Config file symlinks
setup_symlinks "$dotfiles/links"

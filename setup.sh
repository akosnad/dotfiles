#!/bin/bash
set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

$dotfiles/setup-minimal.sh

if ! [ -f /usr/bin/Xorg ]; then
    yay -Ss xf86-video
    echo "\n\nNo X server found, please install xorg-server, and a video driver if using full setup"
    echo "Otherwise run setup-minimal if you plan on running console-only."
    echo "\nAvailable video driver packages are listed above"
    exit 1
fi

### Packages
verify_packages "$dotfiles/packages"

### X server related
sudo systemctl enable lightdm

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

### Flavours
flavour_conf="$dotfiles/flavours/config.toml"
if [ -f "$flavour_conf" ]; then rm "$flavour_conf"; fi
ln -s $dotfiles/flavours/config-full.toml $flavour_conf

### Xresources
include_text "#include \"$dotfiles/Xresources\"" "$HOME/.Xresources"
mkdir -p "$HOME/.Xresources.d"
include_text "#include \".Xresources.d/colors\"" "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources"

### Cpan packages
sudo cpan $(awk '$1=$1' ORS=' ' packages-cpan)

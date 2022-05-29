#!/bin/bash
set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

$dotfiles/setup-minimal.sh

if ! [ -f /usr/bin/Xorg ]; then
    yay -Ss xf86-video
    printf "\n\nNo X server found, please install xorg-server, and a video driver if using full setup\n"
    printf "Otherwise run setup-minimal if you plan on running console-only.\n"
    printf "\nAvailable video driver packages are listed above\n"
    touch $dotfiles/awesome/.first-run
    exit 1
fi

### Packages
verify_packages "$dotfiles/packages"

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
mkdir -p "$HOME/.Xresources.d"
setup_symlinks "$dotfiles/links"

### Udev rules
pushd $dotfiles/udev &>/dev/null
for f in $(find . -maxdepth 1 -type f); do
    if [ ! -f /etc/udev/rules.d/$f ]; then
        sudo cp $f /etc/udev/rules.d/.
    fi
done
popd &>/dev/null

### X11 config
pushd $dotfiles/xorg &>/dev/null
for f in $(find . -maxdepth 1 -type f); do
    if [ ! -f /etc/X11/xorg.conf.d/$f ]; then
        sudo cp $f /etc/X11/xorg.conf.d/.
    fi
done
popd &>/dev/null

### X server related
sudo systemctl enable lightdm
systemctl --user enable pulseaudio
if ! grep -q -E '^theme-name' /etc/lightdm/lightdm-gtk-greeter.conf; then
    sudo sh -c 'echo "theme-name=FlatColor" >> /etc/lightdm/lightdm-gtk-greeter.conf'
fi
if ! grep -q -E '^icon-theme-name' /etc/lightdm/lightdm-gtk-greeter.conf; then
    sudo sh -c 'echo "icon-theme-name=Papirus-Dark" >> /etc/lightdm/lightdm-gtk-greeter.conf'
fi
if ! (xrdb -query | grep -qE "^awesome.started:\s*true$"); then
    printf "\n\nNot running in the graphical environment\nPlease reboot and rerun this script from a terminal under the graphical environment\n"
    printf "Also, please check if all X configuration is correct in /etc/X11/xorg.conf.d/ before running for the first time\n"
    exit 1
fi

### Neovim
include_text "hi Normal guibg=NONE ctermbg=NONE" "$HOME/.config/nvim/init.vim"

### Xresources
include_text "#include \".Xresources.d/colors\"" "$HOME/.Xresources"
include_text "#include \"$dotfiles/Xresources\"" "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources"

### Flavours
flavour_conf="$dotfiles/flavours/config.toml"
rm -f "$flavour_conf"
ln -s $dotfiles/flavours/config-full.toml $flavour_conf
if [ -f $dotfiles/awesome/.first-run ]; then
    rm $dotfiles/awesome/.first-run
    if ! flavours current &>/dev/null; then
        flavours apply equilibrium-dark
    else
        flavours apply $(flavours current)
    fi
fi

### Startup apps
mkdir -p $HOME/.config/autostart
dex -c /usr/bin/redshift-gtk -t $XDG_CONFIG_HOME/autostart
dex -c /usr/bin/fusuma -t $XDG_CONFIG_HOME/autostart

###
printf "\n\nFull setup complete\n"

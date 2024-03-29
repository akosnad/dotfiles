#!/bin/bash
set -e
source "helpers.sh"

setup_dependency minimal

if ! yay -Qs xf86-video &>/dev/null; then
    yay -Ss xf86-video
    printf "\n\nNo Xorg video driver found, please install one corresponding to your hardware if using full setup!\n"
    printf "Otherwise run setup-minimal if you plan on running console-only.\n"
    printf "\nAvailable video driver packages are listed above\n"
    touch $dotfiles/awesome/.first-run
    exit 1
fi

### GTK
source gtk.sh

### Udev rules
pushd $dotfiles/udev
for f in $(find . -maxdepth 1 -type f); do
    if [ ! -f /etc/udev/rules.d/$f ]; then
        sudo cp $f /etc/udev/rules.d/.
    fi
done
popd

### X11 config
pushd $dotfiles/xorg
sudo cp 30-touchpad.conf /etc/X11/xorg.conf.d/.
if yay -Qs xf86-video-intel &>/dev/null; then
    sudo cp 20-intel.conf /etc/X11/xorg.conf.d/.
fi
popd

### X server related
sudo systemctl enable -f lightdm
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
source flavours.sh full

### Startup apps
mkdir -p $HOME/.config/autostart
dex -c /usr/bin/redshift-gtk -t $XDG_CONFIG_HOME/autostart
dex -c /usr/bin/fusuma -t $XDG_CONFIG_HOME/autostart

### Services
pushd $dotfiles/services
./link_services.sh
popd
systemctl --user enable powerline-daemon
systemctl --user enable --now powerline-fix

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

### Flavours
flavour_conf="$dotfiles/flavours/config.toml"
if [ -f "$flavour_conf" ]; then rm "$flavour_conf"; fi
ln -s $dotfiles/flavours/config-full.toml $flavour_conf
if ! flavours current &>/dev/null; then
    flavours apply equilibrium-dark
fi
if [ -f $dotfiles/awesome/.first-run ]; then
    rm $dotfiles/awesome/.first-run
    flavours apply $(flavours current)
fi

### Neovim
include_text "hi Normal guibg=NONE ctermbg=NONE" "$HOME/.config/nvim/init.vim"

### X server related
sudo systemctl enable lightdm
systemctl --user enable pulseaudio
if ! grep -q -E '^theme-name' /etc/lightdm/lightdm-gtk-greeter.conf; then
    sudo sh -c 'echo "theme-name=FlatColor" >> /etc/lightdm/lightdm-gtk-greeter.conf'
fi
if ! grep -q -E '^icon-theme-name' /etc/lightdm/lightdm-gtk-greeter.conf; then
    sudo sh -c 'echo "icon-theme-name=Papirus-Dark" >> /etc/lightdm/lightdm-gtk-greeter.conf'
fi
if ! (set | egrep -q "^DISPLAY"); then
    printf "\n\nNot running in an X environment\nPlease reboot and rerun this script from a terminal under the graphical environment\n"
    exit 1
fi

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

### Xresources
include_text "#include \".Xresources.d/colors\"" "$HOME/.Xresources"
include_text "#include \"$dotfiles/Xresources\"" "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources"

### Startup apps
mkdir -p $HOME/.config/autostart
dex -c /usr/bin/redshift-gtk -t $XDG_CONFIG_HOME/autostart
dex -c /usr/bin/fusuma -t $XDG_CONFIG_HOME/autostart

### Discord
running_before=$(if (pidof Discord &>/dev/null); then echo 1; fi)
if [[ $(betterdiscordctl status | grep "injected: no") ]]; then
    betterdiscordctl install
fi
/usr/bin/discord </dev/null &>/dev/null &
python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip
mkdir -p "$HOME/.config/beautifuldiscord"
$HOME/.local/bin/beautifuldiscord --css "$HOME/.config/beautifuldiscord/style.css"
if [[ ! $running_before == "1" ]]; then killall -INT Discord &>/dev/null; fi

###
printf "\n\nFull setup complete\n"

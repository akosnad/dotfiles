#!/bin/bash
set -e
source "helpers.sh"

setup_dependency minimal

### For brightness control
sudo usermod -a -G video $USER

### Greetd
greeter_home_dir="/var/lib/greeter"
sudo usermod -a -G seat $USER
sudo mkdir -p $greeter_home_dir
sudo usermod -d $greeter_home_dir greeter &>/dev/null
sudo cp $setup_dir/greeter-user.sh $greeter_home_dir
sudo chown -R greeter:greeter $greeter_home_dir
sudo -u greeter bash $greeter_home_dir/greeter-user.sh
sudo systemctl enable -f greetd
pushd $dotfiles/greetd
for f in $(find . -maxdepth 1 -type f); do
    sudo cp $f /etc/greetd/.
done
popd
sudo sh -c 'echo "Hyprland" > /etc/greetd/environments'

### GTK
source gtk.sh

### Electron apps + chrome flags
include_text '--enable-features=UseOzonePlatform' "$HOME/.config/electron-flags.conf"
include_text '--ozone-platform=wayland' "$HOME/.config/electron-flags.conf"
include_text '--ozone-platform-hint=auto' "$HOME/.config/chrome-flags.conf"

### Services
pushd $dotfiles/services
./link_services.sh
popd
systemctl --user enable --now geoclue-agent
systemctl --user enable --now gammastep

### Flavours
source flavours.sh hypr

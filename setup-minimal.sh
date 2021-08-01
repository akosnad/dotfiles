#!/bin/bash
set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

git submodule update --init

### Packages
if ! command -v yay >/dev/null; then
    read -p "Yay is not installed, continue? (y/n) " reply
    if ! [ "$reply" == "y" ]; then
        exit 1
    fi
    sudo pacman -S --needed --noconfirm base-devel
    source="$(mktemp -d)"
    pushd "$source"
    git clone https://aur.archlinux.org/yay.git
    pushd yay
    makepkg -si --noconfirm
    popd; popd
    rm -rf "$source"
fi
yay -Syu
verify_packages "$dotfiles/packages-minimal"

### Zsh
if ! egrep -q "^$USER\:.*zsh\$" /etc/passwd; then
    echo "Setting user shell to zsh"
    sudo usermod -s /bin/zsh $USER
fi
include_text ". $dotfiles/zsh/zshrc.sh" "$HOME/.zshrc"
include_text "source $dotfiles/.profile" "$HOME/.profile"


### Neovim
mkdir -p $HOME/.config/nvim
include_text "so $dotfiles/vim/vimrc.vim" "$HOME/.config/nvim/init.vim"
include_text "silent! so $HOME/.config/nvim/colorscheme.vim" "$HOME/.config/nvim/init.vim"
nvim +"source $dotfiles/setup.vim"
sudo npm i -g neovim
sudo pip install neovim

### Config file symlinks
setup_symlinks "$dotfiles/links-minimal"

### Flavours
flavour_conf="$dotfiles/flavours/config.toml"
if [ -f "$flavour_conf" ]; then rm "$flavour_conf"; fi
ln -s $dotfiles/flavours/config-minimal.toml $flavour_conf
if [ ! -d "$HOME/.local/share/flavours" ]; then
    flavours update all
fi

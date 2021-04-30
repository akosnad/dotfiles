#!/bin/bash
set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

### Packages
yay -Syu
verify_packages "$dotfiles/packages-minimal"

### Zsh
include_text ". $dotfiles/zsh/zshrc.sh" "$HOME/.zshrc"

### Neovim
mkdir -p $HOME/.config/nvim
include_text "so $dotfiles/vim/vimrc.vim" "$HOME/.config/nvim/init.vim"
nvim +"source $dotfiles/setup.vim"

### Config file symlinks
setup_symlinks "$dotfiles/links-minimal"

### Flavours
if [ ! -d "$HOME/.local/share/flavours" ]; then
    flavours update all
fi

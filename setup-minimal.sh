#!/bin/bash
#set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"
source "$dotfiles/setup-helpers.sh"

### Packages
yay -Syu
verify_packages "$dotfiles/packages-minimal"

### Base16
while read r; do
    if [ ! -d "$HOME/.base16-manager/$r" ]; then
        base16-manager install "$r"
    fi
done < base16-repos

### Zsh
include_text ". $dotfiles/zsh/zshrc.sh" "$HOME/.zshrc"

### Neovim
mkdir -p $HOME/.config/nvim
include_text "so $dotfiles/vim/vimrc.vim" "$HOME/.config/nvim/init.vim"
nvim +"source $dotfiles/setup.vim"

### Config file symlinks
setup_symlinks "$dotfiles/links-minimal"

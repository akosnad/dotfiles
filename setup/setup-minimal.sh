#!/bin/bash
set -e
source "helpers.sh"

### Zsh
if ! egrep -q "^$USER\:.*zsh\$" /etc/passwd; then
    echo "Setting user shell to zsh"
    sudo usermod -s /bin/zsh $USER
fi
include_text ". $dotfiles/zsh/zshrc.sh" "$HOME/.zshrc"
include_text "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" "$HOME/.zshrc"
include_text "[ -f $HOME/.fzf.colors ] && source $HOME/.fzf.colors" "$HOME/.zshrc"
include_text "[ -f $HOME/.base16_theme ] && source $HOME/.base16_theme" "$HOME/.zshrc"
include_text "source $dotfiles/.profile" "$HOME/.profile"


### Neovim
include_text "so $dotfiles/vim/vimrc.vim" "$HOME/.config/nvim/init.vim"
include_text "silent! so $HOME/.config/nvim/colorscheme.vim" "$HOME/.config/nvim/init.vim"
include_text "silent! so $HOME/.config/nvim/airline-colors.vim" "$HOME/.config/nvim/init.vim"
sudo yarn -s global add neovim
sudo pip -q install neovim
nvim +"source $setup_dir/setup.vim"

### Flavours
source flavours.sh minimal


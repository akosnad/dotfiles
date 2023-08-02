#!/bin/bash
set -e
source "helpers.sh"

### Zsh
if ! grep -Eq "^$USER:.*zsh\$" /etc/passwd; then
    echo "Setting user shell to zsh"
    sudo usermod -s /bin/zsh $USER
fi
include_text ". $dotfiles/zsh/zshrc.sh" "$HOME/.zshrc"
# include_text "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" "$HOME/.zshrc"
# include_text "[ -f $HOME/.fzf.colors ] && source $HOME/.fzf.colors" "$HOME/.zshrc"
# include_text "[ -f $HOME/.base16_theme ] && source $HOME/.base16_theme" "$HOME/.zshrc"
include_text "source $dotfiles/.profile" "$HOME/.profile"


### Neovim

# remove old config
[ -f "$HOME/.config/nvim/init.vim" ] && rm "$HOME/.config/nvim/init.vim"

include_text "require(\"config\")" "$HOME/.config/nvim/init.lua"
sudo yarn -s global add neovim
nvim "+Lazy! sync" +qa

### Flavours
source flavours.sh minimal


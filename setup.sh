#!/bin/bash
set -e

yay -Syu $(cat packages | tr '\n' ' ')

xargs base16-manager install < base16-repos
base16-manager set embers

echo ". $PWD/zsh/zshrc.sh" > $HOME/.zshrc
mkdir -p $HOME/.config/nvim
echo "so $PWD/vim/vimrc.vim" > $HOME/.config/nvim/init.vim

while read line; do
	source=$(echo $line | sed "s/\:.*$//")
	dest=$(echo $line | sed "s/^.*\://")
 	ln -s "$PWD/$dest" "$HOME/$source" 
done <links

nvim +PluginUpdate +qa
nvim +CocInstall coc-json coc-tsserver +qa

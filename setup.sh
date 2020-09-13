#!/bin/bash
set -e

yay -Syu $(cat packages | tr '\n' ' ')

xargs base16-manager < base16-repos
base16-manager set embers

echo ". $PWD/zsh/zshrc.sh" > $HOME/.zshrc

while read line; do
	source=$(echo $line | sed "s/\:.*$//")
	dest=$(echo $line | sed "s/^.*\://")
	ln -s "$PWD/$dest" "$HOME/$source" 
done <links


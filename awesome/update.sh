#!/bin/zsh

source ~/.zshrc
cd ~/dotfiles
git pull && ./setup.sh
printf "\nPress enter to exit"
read

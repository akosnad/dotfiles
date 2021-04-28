#!/bin/bash
#set -e
dotfiles="$(dirname $(realpath $BASH_SOURCE))"

# arg 1: include text
# arg 2: file to check in or to create
function include_text() {
    if ! grep -q "$1" "$2" >/dev/null 2>&1; then
        echo $1 >> $2
    fi
}

### Packages
yay -Syu
yay -Qn > .installed # we put it in a file, so we don't call it every loop :/ kinda slow
yay -Qm >> .installed
while read p; do
    if ! grep -P "^$p\ .*$" .installed >/dev/null 2>&1; then
        if ! grep -P "^$p\ .*$" .installed >/dev/null 2>&1; then
            yay -S --noconfirm --quiet --needed --nocleanmenu --noeditmenu --nodiffmenu "$p"
        fi
    fi
done < packages
rm .installed

### Xresources
include_text "#include \"$dotfiles/Xresources\"" "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources"

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
while read -u 3 line; do
	source="$HOME/$(echo $line | sed "s/\:.*$//")"
	dest="$dotfiles/$(echo $line | sed "s/^.*\://")"
    if [ ! -L "$source" ]; then
        if [ -f "$source" ]; then
            read -p "$source exists, and is not a symlink, replace it? (y/n) " reply
            if [ "$reply" == "y" ]; then
                rm "$source"
            else
                continue
            fi
        fi
 	    ln -s "$dest" "$source" 
    fi
done 3<links

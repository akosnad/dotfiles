set nocompatible
filetype off

set rtp+=$HOME/dotfiles/vim/vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'AlessandroYorba/Alduin'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

colorscheme alduin

let NERDTreeShowHidden=1
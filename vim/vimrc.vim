set nocompatible
filetype off

set rtp+=$HOME/dotfiles/vim/vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-commentary'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'rbgrouleff/bclose.vim'

call vundle#end()
filetype plugin indent on

syntax on
set autoindent
set hlsearch
set mouse=a
set incsearch

let base16colorspace=256
set termguicolors

function Startup()
	if @% == ""
		" Ranger
	endif
endfunction
au vimenter * call Startup()

" let g:ranger_replace_netrw = 1

source $HOME/dotfiles/vim/binds.vim
silent! so $HOME/.vim/colorscheme.vim

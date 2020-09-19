set nocompatible 
filetype off

source $HOME/dotfiles/vim/vim-plug/plug.vim
call plug#begin()

Plug 'VundleVim/Vundle.vim'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim'

call plug#end()
filetype plugin indent on

syntax on
set number
set autoindent
set hlsearch
set mouse=a
set incsearch

let base16colorspace=256
set termguicolors

function Startup()
	if @% == ""
		Ranger
	endif
endfunction
au vimenter * call Startup()

let g:ranger_replace_netrw = 1

source $HOME/dotfiles/vim/binds.vim
source $HOME/dotfiles/vim/coc.vim
silent! so $HOME/.vim/colorscheme.vim

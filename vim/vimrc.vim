set nocompatible 
filetype off

source $HOME/dotfiles/vim/vim-plug/plug.vim
call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-reload'
Plug 'jreybert/vimagit'

call plug#end()
filetype plugin indent on

syntax on
set number
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set mouse=a
set incsearch
let base16colorspace=16
set notermguicolors
set t_Co=16
set noshowmode

function Startup()
	if @% == ""
		Ranger
	endif
endfunction
au vimenter * call Startup()

let g:ranger_replace_netrw = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

source $HOME/dotfiles/vim/binds.vim
source $HOME/dotfiles/vim/coc.vim
silent! so $HOME/.vim/colorscheme.vim

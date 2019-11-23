set nocompatible
filetype off

set rtp+=$HOME/dotfiles/vim/vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'AlessandroYorba/Alduin'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()
filetype plugin indent on

syntax on
set autoindent
set hlsearch
set mouse=a
set incsearch

colorscheme alduin

let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
autocmd vimenter * call NERDTreeStartup()
function NERDTreeStartup()
    NERDTree %:p:h
    wincmd p
endfunction
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

source $HOME/dotfiles/vim/binds.vim
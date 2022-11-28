set nocompatible
filetype off

source $HOME/dotfiles/vim/vim-plug/plug.vim

function UpdateCocPlug(info)
    if a:info.status != "unchanged"
        echo "Updating" a:info.name
        !yarn install --frozen-lockfile
    endif
endfunction

call plug#begin()

Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-reload'
Plug 'jreybert/vimagit'
Plug 'cespare/vim-toml'
Plug 'chrisbra/csv.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'mhinz/vim-crates'
Plug 'embear/vim-localvimrc'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'

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
set t_Co=256
let base16colorspace=256
set termguicolors
set noshowmode
set listchars=tab:→\ ,nbsp:+,space:·

function Startup()
    if @% == ""
        Ranger
    endif
endfunction
au vimenter * call Startup()

let g:ranger_replace_netrw = 1

let g:airline_theme = 'base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

let g:lsp_cxx_hl_use_text_props = 1
" highlight LspCxxHlSymVariable ctermfg=Black guifg=Black
" highlight LspCxxHlSymClassMethod ctermfg=Black guifg=Black

augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:hor20
augroup END

set guicursor=n-v-sm:block,i-c-ci-ve:ver25,i-c-ci-ve:blinkon5,r-cr-o:hor20

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 1


if !exists('*TrapSignal')
    function TrapSignal()
        colorscheme default
        source ~/.config/nvim/init.vim
        AirlineRefresh
    endfunction
endif
autocmd Signal SIGUSR1 call TrapSignal()

let g:vimtex_view_method = 'xdvi'

source $HOME/dotfiles/vim/binds.vim
source $HOME/dotfiles/vim/coc.vim

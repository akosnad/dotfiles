require("binds")
require("init-plugins")
vim.cmd([[
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

    if !exists('*TrapSignal')
        function TrapSignal()
            source $HOME/.config/nvim/colorscheme.vim
            AirlineRefresh
            redraw
        endfunction
    endif
    autocmd Signal SIGUSR1 call TrapSignal()
]])

vim.cmd("source $HOME/.config/nvim/colorscheme.vim")

vim.cmd("hi! link @variable Normal")

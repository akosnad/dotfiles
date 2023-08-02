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
]])

vim.cmd("source $HOME/.config/nvim/colorscheme.vim")

vim.cmd("hi! link @variable Normal")

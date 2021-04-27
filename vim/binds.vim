set pastetoggle=<F2>

let mapleader=','

inoremap <leader>w <Esc>:w<CR>
nnoremap <leader>w :w<CR>

inoremap <leader>q <ESC>:q<CR>
inoremap <leader>Q <ESC>:q!<CR>
noremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

inoremap <leader>x <ESC>:x<CR>
nnoremap <leader>x :x<CR>

nnoremap <leader>t :tabnew<CR>:FZF<CR>
nnoremap <leader>n :tabN<CR>

nnoremap <leader>F :FZF<CR>

nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
" X Clipboard
nnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>Y "+y
nnoremap <leader>Y "+y

" Terminal mode
tnoremap <Esc> <C-\><C-n>

" Window navigation
nnoremap <M-Left> <C-W>h
nnoremap <M-Right> <C-W>l
nnoremap <M-Up> <C-W>k
nnoremap <M-Down> <C-W>j

nnoremap <M-Left> <C-W>h
nnoremap <M-Right> <C-W>l
nnoremap <M-Up> <C-W>k
nnoremap <M-Down> <C-W>j

nnoremap <leader><Left> <C-W>H
nnoremap <leader><Right> <C-W>L
nnoremap <leader><Up> <C-W>K
nnoremap <leader><Down> <C-W>J

nnoremap <S-Left> <C-W>>
nnoremap <S-Right> <C-W><
nnoremap <S-Up> <C-W>-
nnoremap <S-Down> <C-W>+


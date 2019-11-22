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

nnoremap <leader>e :NERDTreeToggle<CR>

nnoremap <leader>t :tabnew<CR>:Ex<CR>
nnoremap <leader>n :tabN<CR>

nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
" X Clipboard
nnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap <leader>Y "+y
nnoremap <leader>Y "+y

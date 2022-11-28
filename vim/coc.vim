set nobackup nowritebackup hidden
set updatetime=300
set shortmess+=c
set pyxversion=3

let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-json',
            \ 'coc-lua', 
            \ 'coc-rust-analyzer',
            \ 'coc-sh',
            \ 'coc-tsserver',
            \ 'coc-toml',
            \ 'coc-stylelint',
            \ 'coc-cmake',
            \ 'coc-clangd',
            \ 'coc-webview',
            \ 'coc-markdown-preview-enhanced',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-vimtex',
            \ 'coc-gitignore',
            \ 'coc-prettier',
            \ 'coc-git',
            \ ]

let g:coc_default_semantic_highlight_groups = 1

if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Tab for trigger completion
inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" C-space to trigger completion
if has("nvim")
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Space to show definition
nnoremap <silent> <space> :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)w
nmap <silent> <leader>l :CocFzfList<CR>
nmap <silent> <leader><space> :CocFzfList symbols<CR>

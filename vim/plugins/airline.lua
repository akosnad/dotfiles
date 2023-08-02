return {
    {
        'vim-airline/vim-airline',
        lazy = false,
        config = function()
            vim.g.airline_theme = 'base16'
            vim.g['airline#extensions#tabline#enabled'] = 1
            vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
            vim.g.airline_powerline_fonts = 1
        end
    },
    {
        'vim-airline/vim-airline-themes'
    }
}

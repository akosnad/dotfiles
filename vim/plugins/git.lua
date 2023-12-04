return {
    {
        'jreybert/vimagit',
        cmd = 'Magit',
        keys = { '<leader>m' },
        config = function()
            vim.keymap.set('n', '<leader>m', function()
                vim.fn.execute('Magit')
            end, { noremap = true })
        end
    },
    {
        'tpope/vim-fugitive',
    }
}

return {
    {
        'junegunn/fzf',
        lazy = true,
        build = function()
            vim.fn['fzf#install']()
        end,
    },
    {
        'junegunn/fzf.vim',
        lazy = true,
        cmd = "FZF",
        keys = { '<leader>F' },
        dependencies = {
            'junegunn/fzf',
        },
        config = function()
            vim.keymap.set('n', '<leader>F', ':FZF<CR>', { silent = true, noremap = true })
        end,
    },
    {
        'antoinemadec/coc-fzf',
        cmd = "CocFzfList",
        dependencies = {
            'junegunn/fzf.vim',
        }
    }
}

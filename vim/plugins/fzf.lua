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
        cmd = { "FZF", "Ag" },
        keys = { '<leader>F' },
        dependencies = {
            'junegunn/fzf',
        },
        config = function()
            vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }
            vim.keymap.set('n', '<leader>F', '<cmd>FZF<cr>', { silent = true, noremap = true })
        end
    },
    {
        'antoinemadec/coc-fzf',
        cmd = "CocFzfList",
        dependencies = {
            'junegunn/fzf.vim',
        }
    }
}

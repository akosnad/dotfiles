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
        dependencies = {
            'junegunn/fzf',
        },
    },
    {
        'antoinemadec/coc-fzf',
        cmd = "CocFzfList",
        dependencies = {
            'junegunn/fzf.vim',
        }
    }
}

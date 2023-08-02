return {
    {
        'github/copilot.vim',
        branch = 'release',
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""

            vim.keymap.set('i', '<leader><tab>', function()
                vim.fn['copilot#Accept(\'<CR>\')']()
            end, { expr = true, silent = true, noremap = true })
        end
    }
}

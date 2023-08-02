return {
    {
        'neoclide/coc.nvim',
        branch = 'release',
        config = function()
            vim.g.coc_global_extensions = {
                'coc-snippets',
                'coc-json',
                'coc-lua',
                'coc-rust-analyzer',
                'coc-sh',
                'coc-tsserver',
                'coc-toml',
                'coc-stylelint',
                'coc-cmake',
                'coc-clangd',
                'coc-webview',
                'coc-markdown-preview-enhanced',
                'coc-html',
                'coc-css',
                'coc-vimtex',
                'coc-gitignore',
                'coc-prettier',
                'coc-git',
                'coc-marketplace',
            }

            vim.g.nobackup = true
            vim.g.nowritebackup = true
            vim.g.hidden = true
            vim.g.updatetime = 300
            vim.g.shortmess = (vim.g.shortmess or '') .. 'c'

            vim.g.coc_default_semantic_highlight_groups = 1
            vim.g.signcloumn = "number"

            local function check_back_space()
                local col = vim.fn.col('.') - 1
                return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
            end

            local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

            vim.keymap.set("i", "<Tab>",
                function()
                    if vim.fn['coc#pum#visible']() == 1 then
                        return vim.fn['coc#pum#next'](1)
                    end
                    if vim.fn['coc#expandableOrJumpable']() == 1 then
                        return "<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])<CR>"
                    end
                    if check_back_space() then
                        return vim.fn['coc#refresh']()
                    end
                    return "<Tab>"
                end
                , opts)

            vim.keymap.set("i", "<S-Tab>", function()
                if vim.fn['coc#pum#visible']() == 1 then
                    return vim.fn['coc#pum#prev'](1)
                end
                return "<S-Tab>"
            end, opts)

            vim.keymap.set("i", "<CR>", function()
                if vim.fn['coc#pum#visible']() == 1 then
                    return vim.fn['coc#pum#confirm']();
                end
                return "\r"
            end, opts)

            vim.keymap.set('n', '<space>', function()
                if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
                    vim.fn.execute('h ' .. vim.fn.expand('<cword>'))
                else
                    vim.fn['coc#doHover']()
                end
            end, { silent = true, noremap = true })
        end
    }
}

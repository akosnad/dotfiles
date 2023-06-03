local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local packer_config = require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { 'https://codeberg.org/esensar/nvim-dev-container' }

    if packer_bootstrap then
        require('packer').sync()
    end
end)


vim.opt.foldmethod = 'expr'
vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
-- WORKAROUND: treesitter folding is broken
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
--     group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--     callback = function()
--         vim.opt.foldmethod = 'expr'
--         vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
--     end
-- })

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'jsonc' }
}

require('devcontainer').setup {}

return packer_config

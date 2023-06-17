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

local plugin_list = {
    'plugin.coc',
    'plugin.copilot',
    'plugin.ranger',
    'plugin.airline',
}

local packer_bootstrap = ensure_packer()
local packer_config = require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    if packer_bootstrap then
        require('packer').sync()
    end

    use 'tpope/vim-commentary'

    for _, plugin_name in ipairs(plugin_list) do
        use(require(plugin_name).packer)
    end
end)

return packer_config

local module = {
	packer = {
		'francoiscabrol/ranger.vim',
		config = function()
			vim.g.ranger_replace_netrw = 1
		end
	}
}

return module

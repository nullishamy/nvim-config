vim.o.termguicolors = true
vim.o.background = 'dark'

-- Enable italics, for comments etc
vim.g.one_allow_italics = 1

require('onedark').setup({
	style = 'deep',
	-- Basically a no-op because this bind, by default, interferes with other binds
	toggle_style_key = '<F20>',
})
require('onedark').load()

vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.one_alow_italics = 1

require('onedark').setup {
    style = 'deep',
    -- Basically a no-op because this bind, by default, interferes with other binds
    toggle_style_key = '<F20>'
}
require('onedark').load()

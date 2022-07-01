local map = require('utils').map

map('', '<leader>h', ':FocusSplitLeft<CR>')
map('n', '<leader>j', ':FocusSplitDown<CR>')
map('n', '<leader>k', ':FocusSplitUp<CR>')
map('n', '<leader>l', ':FocusSplitRight<CR>')

require("focus").setup()

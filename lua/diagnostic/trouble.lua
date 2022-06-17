local map = require("utils").map

require("trouble").setup {
    auto_open = true,
    position = 'bottom',
}

map('', '<Leader>e', '<cmd>TroubleRefresh<cr>')
map('n', '<Leader>t', '<cmd>Trouble workspace_diagnostics<cr>')

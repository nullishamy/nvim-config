local map = require("utils").map

require("trouble").setup {
    auto_close = true,
    auto_open = true,
}

map('', '<Leader>e', '<cmd>TroubleRefresh<cr>')
map('n', '<Leader>t', '<cmd>Trouble workspace_diagnostics<cr>')

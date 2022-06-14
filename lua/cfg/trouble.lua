local map = require("utils").map

require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

map('n', '<Leader>e', '<cmd>TroubleRefresh<cr>')

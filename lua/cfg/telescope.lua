local map = require("utils").map

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

map("", "<Leader>f", ":lua require('telescope.builtin').find_files()<cr>")
map("", "<Leader>g", ":CHADopen --always-focus<cr>")
map("", "<Leader>o", ":lua require('telescope.builtin').buffers()<cr>")


local utils = require('utils')
local map = utils.map
local abbrev = utils.abbrev

--Remap space as leader key
map('', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Quick exit from insert mode
map('i', 'jk', '<Esc>')

-- Disable arrow keys to force hjkl usage
map('n', '<Up>', '<Nop>')
map('n', '<Down>', '<Nop>')
map('n', '<Left>', '<Nop>')
map('n', '<Right>', '<Nop>')

-- Buffer controls
map('', '<C-h>', '<Plug>(cokeline-focus-prev)')
map('', '<C-l>', '<Plug>(cokeline-focus-next)')
map('', '<Leader>q', '<cmd>Bdelete<cr>')

-- Navigation  controls
map('', '<Leader>f', '<cmd>Telescope find_files<cr>')
map('n', '<Leader>o', '<cmd>Telescope buffers<cr>')
map('n', '<Leader>g', '<cmd>Neotree focus reveal<cr>')

-- Jump to start / end
map('n', 'H', '^')
map('n', 'L', '$')

-- Hard close vim with ctrl q + q
map('n', '<C-q>q', '<cmd>qa!<cr>')

-- Terminal
map('n', '<C-t>', '<cmd>lua require("FTerm").toggle()<cr>')
map('t', '<C-t>', '<C-\\><C-n><cmd>lua require("FTerm").toggle()<cr>')
map('t', '<Esc>', '<C-\\><C-n>')

-- Trouble
map('n', '<Leader>t', '<cmd>Trouble workspace_diagnostics<cr>')

-- Sessions
map('n', '<Leader>sl', '<cmd>SessionManager load_session<cr>')
map('n', '<Leader>sd', '<cmd>SessionManager delete_session<cr>')
map('n', '<Leader>ss', '<cmd>SessionManager save_current_session<cr>')

-- Focus
map('n', '<leader>h', '<cmd>FocusSplitLeft<CR>')
map('n', '<leader>j', '<cmd>FocusSplitDown<CR>')
map('n', '<leader>k', '<cmd>FocusSplitUp<CR>')
map('n', '<leader>l', '<cmd>FocusSplitRight<CR>')

-- Winshift
map('n', '<C-W>m', '<cmd>WinShift<cr>')

-- Abbreviations
abbrev('Git', 'Neotree focus source=git_status position=float')
abbrev('Grep', function()
  require('telescope.builtin').live_grep()
end)

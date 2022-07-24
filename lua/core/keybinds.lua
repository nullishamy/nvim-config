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
map('', '<Leader>f', ':Telescope find_files<CR>')
map('n', '<Leader>o', ':Telescope buffers<CR>')
map('n', '<Leader>g', ':Neotree focus reveal<CR>')

-- Hard close vim with ctrl q + q
map('n', '<C-q>q', ':qa!<CR>')

-- Terminal
map('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>')
map('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
map('t', '<Esc>', '<C-\\><C-n>')

-- Trouble
map('n', '<Leader>t', '<cmd>Trouble workspace_diagnostics<cr>')

-- Sessions
map('n', '<Leader>sl', '<cmd>SessionManager load_session<cr>')
map('n', '<Leader>sd', '<cmd>SessionManager delete_session<cr>')
map('n', '<Leader>ss', '<cmd>SessionManager save_current_session<cr>')

-- Focus
map('n', '<leader>h', ':FocusSplitLeft<CR>')
map('n', '<leader>j', ':FocusSplitDown<CR>')
map('n', '<leader>k', ':FocusSplitUp<CR>')
map('n', '<leader>l', ':FocusSplitRight<CR>')

-- Abbreviations
abbrev('Git', 'Neotree focus source=git_status position=float')
abbrev('Grep', 'lua require(\'telescope.builtin\').live_grep()')

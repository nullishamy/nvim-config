local map = require('utils').map

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

-- Hide highlights
map('n', '<Leader>d', ':nohlsearch<cr>')

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
map('n', '<C-t>', ':term<CR>', { noremap = true }) -- open
map('t', '<Esc>', '<C-\\><C-n>') -- exit

-- Trouble
map('n', '<Leader>t', '<cmd>Trouble workspace_diagnostics<cr>')

-- Sessions
map('n', '<Leader>sl', '<cmd>SessionManager load_session<cr>')
map('n', '<Leader>sd', '<cmd>SessionManager delete_session<cr>')
map('n', '<Leader>ss', '<cmd>SessionManager save_current_session<cr>')

-- Stay in indent mode
map('n', '<', '<gv')
map('n', '>', '>gv')

-- Focus
map('n', '<leader>h', ':FocusSplitLeft<CR>')
map('n', '<leader>j', ':FocusSplitDown<CR>')
map('n', '<leader>k', ':FocusSplitUp<CR>')
map('n', '<leader>l', ':FocusSplitRight<CR>')

local map = require("utils").map

--Remap space as leader key
map("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick exit from insert mode
map("i", "jk", "<Esc>")

-- Jump 10 lines at a time
map("", "<S-j>", "<cmd>+10<cr>", { silent = true })
map("", "<S-k>", "<cmd>-10<cr>", { silent = true })

-- Disable arrow keys to force hjkl usage
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")

map("n", "<Leader>d", ":nohlsearch<cr>")

-- Buffer controls
map("", "<C-h>", ":BufferLineCyclePrev<cr>")
map("", "<C-l>", ":BufferLineCycleNext<cr>")
map("", "<Leader>q", ":bp<bar>sp<bar>bn<bar>bd<cr>")

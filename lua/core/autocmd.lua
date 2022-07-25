-- Line numbers should be relative in normal mode
-- but absolute in insert mode.
vim.cmd([[ 
    :augroup NumberToggle 
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    :augroup END
]])

-- Don't auto comment new lines
vim.cmd([[ 
  autocmd BufEnter * set fo-=c fo-=r fo-=o  
]])

-- Disable annoying autoindent rules
vim.cmd([[ 
 autocmd BufEnter,WinEnter,FocusGained * set nocin nosi inde= 
]])

-- Disable highlight searching for every buffer
vim.cmd([[
 autocmd BufEnter,WinEnter,FocusGained * set nohlsearch
]])

-- Recompile packer config when it changes
vim.cmd([[
 autocmd BufWritePost preload.lua source <afile> | PackerCompile
]])

-- Set colours when floats open, overwrites colour scheme implementations
vim.cmd([[
 autocmd! ColorScheme * highlight NormalFloat guifg=white guibg=#1a212e 
]])
vim.cmd([[
 autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1a212e
]])

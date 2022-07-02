-- Line numbers should be relative in normal mode
-- but absolute in insert mode.
vim.cmd [[ 
    :augroup numberToggle 
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    :augroup END
]]

-- Don't auto comment new lines
vim.cmd [[ 
  autocmd BufEnter * set fo-=c fo-=r fo-=o  
]]

-- Disable annoying autoindent rules
vim.cmd [[ 
 autocmd BufEnter * set nocin nosi inde= 
]]

-- Recompile packer config when it changes
vim.cmd [[
 autocmd BufWritePost preload.lua source <afile> | PackerCompile
]]

vim.o.completeopt = "menu,noinsert,noselect,preview"
vim.g.noshowmode = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.updatetime = 250

vim.wo.number = true

-- Line numbers should be relative in normal mode
-- but absolute in insert mode.
vim.cmd [[ 
    :augroup numberToggle 
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    :augroup END
]]

local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)
local o = vim.o

-- General
o.completeopt = 'menu,noinsert,noselect,preview'
g.noshowmode = true
g.wrap = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.updatetime = 250
o.mouse = 'a'
opt.scrolloff = 12 -- Keep 12 lines of context on either side of the cursor
vim.wo.number = true

-- Memory & CPU
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 700 -- ms to wait for trigger an event

-- Disable nvim intro
opt.shortmess:append('sI')

-- Disable builtins plugins
local disabled_built_ins = {
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
	'gzip',
	'zip',
	'zipPlugin',
	'tar',
	'tarPlugin',
	'getscript',
	'getscriptPlugin',
	'vimball',
	'vimballPlugin',
	'2html_plugin',
	'logipat',
	'rrhelper',
	'spellfile_plugin',
	'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
	g['loaded_' .. plugin] = 1
end

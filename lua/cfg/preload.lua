-- Init Plug
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- Theming
Plug 'navarasu/onedark.nvim'

-- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'simrat39/rust-tools.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug "williamboman/nvim-lsp-installer"
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

-- Util
Plug 'Pocco81/AutoSave.nvim'
Plug 'sbdchd/neoformat'
Plug 'jghauser/mkdir.nvim'
Plug ('ms-jpq/chadtree', { ['do'] = 'python3 -m chadtree deps' })

-- Misc
Plug 'nvim-lua/plenary.nvim'

-- Selection
Plug 'nvim-telescope/telescope.nvim'

-- Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

-- Bufferline
Plug 'akinsho/bufferline.nvim'

-- Git
Plug 'tpope/vim-fugitive'

vim.call('plug#end')

require("nvim-lsp-installer").setup { }

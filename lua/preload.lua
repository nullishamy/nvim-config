-- Init Plug
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- Theming
Plug 'sainnhe/edge'

-- LSP
Plug 'neovim/nvim-lspconfig'
Plug "williamboman/nvim-lsp-installer"

-- CMP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'

-- Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'glepnir/lspsaga.nvim'

-- Languages
Plug 'simrat39/rust-tools.nvim'

-- Snippets
Plug 'honza/vim-snippets'
Plug 'L3MON4D3/LuaSnip'

-- Diagnostics
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nullishamy/trouble.nvim'

-- Util
Plug 'Pocco81/AutoSave.nvim'
Plug 'jghauser/mkdir.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'kyazdani42/nvim-tree.lua'

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

-- Bootstrap Packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

-- Avoid sourcing filetype.vim, we use our own for performance
vim.g.did_load_filetypes = 1

-- Init Packer
return require('packer').startup(function(use)
  -- Theme
  use('navarasu/onedark.nvim')

  -- LSP
  use('neovim/nvim-lspconfig')
  use('williamboman/nvim-lsp-installer')
  use('folke/lsp-colors.nvim')
  use('jose-elias-alvarez/null-ls.nvim')

  -- CMP
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('saadparwaiz1/cmp_luasnip')

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/nvim-treesitter-textobjects')
  use('p00f/nvim-ts-rainbow')
  use('windwp/nvim-ts-autotag')
  use('windwp/nvim-autopairs')

  -- Languages
  use('simrat39/rust-tools.nvim')
  use({
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  })

  -- Snippets
  use('honza/vim-snippets')
  use('L3MON4D3/LuaSnip')

  -- Diagnostics
  -- Using my fork for line wrapping and other features
  use('nullishamy/trouble.nvim')

  -- Util
  use('Pocco81/AutoSave.nvim')
  use('jghauser/mkdir.nvim')
  use('numToStr/Comment.nvim')
  use('nvim-neo-tree/neo-tree.nvim')
  use('ggandor/leap.nvim')
  use('folke/todo-comments.nvim')
  use('beauwilliams/focus.nvim')
  use('karb94/neoscroll.nvim')
  use('famiu/bufdelete.nvim')
  use('MunifTanjim/nui.nvim')
  use('numToStr/FTerm.nvim')
  use('sindrets/winshift.nvim')
  use('https://gitlab.com/yorickpeterse/nvim-pqf')

  -- Tpope utils
  use('tpope/vim-sleuth')
  use('kylechui/nvim-surround')
  use('tpope/vim-repeat')

  -- Misc
  use('nvim-lua/plenary.nvim')
  use('wbthomason/packer.nvim')
  use({
    'wakatime/vim-wakatime',
    cond = function()
      return require('config').wakatime.enabled
    end,
  })
  use('sheerun/vim-polyglot')
  use('andweeb/presence.nvim')
  use('nathom/filetype.nvim')

  -- Selection
  use('nvim-telescope/telescope.nvim')
  use('stevearc/dressing.nvim')

  -- Statusline
  use('nvim-lualine/lualine.nvim')
  use('kyazdani42/nvim-web-devicons')

  -- Bufferline
  use('noib3/nvim-cokeline')

  -- Git
  use('lewis6991/gitsigns.nvim')

  -- Sessions
  use('Shatur/neovim-session-manager')

  if packer_bootstrap then
    -- If we just bootstrapped, sync.
    -- This will 1) install packer as a dependency and 2) install the rest of the plugins
    require('packer').sync()
  end
end)

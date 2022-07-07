local ok, utils = pcall(require, 'utils')

if (not ok) then
    return vim.notify_once('Failed to load `utils` module, cannot proceed.')
end

local module = utils.load_module

-- Run preload
module('preload')

-- Initialise modules
module('core/autocmd')
module('core/keybinds')
module('theming/colours')
module('core/editor')

-- Core features
module('core/bufferline')
module('core/statusline')

-- Neovide, if it exists
module('core/neovide')

-- Diagnostics and navigation
module('util/tree')
module('diagnostic/lsp')

-- Snippets must be loaded before cmp
module('util/snippets')
module('diagnostic/cmp')

-- Plugins
module('util/autosave')
module('util/autopairs')
module('diagnostic/trouble')
module('util/comment')
module('util/leap')
module('treesitter')
module('util/git')
module('diagnostic/lsp_colours')
module('util/todo')
module('util/focus')
module('util/gui')
module('util/scroll')



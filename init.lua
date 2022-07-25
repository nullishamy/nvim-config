-- Protected in case the module is broken, or something
-- We need it to load modules safely
local ok, utils = pcall(require, 'utils')
if not ok then
  return vim.notify_once('Failed to load `utils` module, cannot proceed.')
end

local module = utils.load_module

-- Run preload
module('preload')

-- Initialise modules
module('core/editor')
module('core/autocmd')
module('core/keybinds')
module('theming/colours')

-- Core features
module('core/statusline')
module('core/sessions')

-- Neovide, if it exists
module('core/neovide')

-- Diagnostics and navigation
module('util/ui/tree')
module('diagnostic/lsp')

-- Snippets must be loaded before cmp
module('util/integrations/snippets')
module('diagnostic/cmp')

-- Plugins
module('treesitter')

module('util/autosave')
module('util/filetype')

module('util/text/autopairs')
module('util/text/surround')
module('util/text/comment')
module('util/text/todo')
module('util/text/cutlass')

module('util/navigation/leap')
module('util/navigation/focus')
module('util/navigation/scroll')

module('util/ui/quickfix')
module('util/ui/gui')
module('util/ui/terminal')

module('util/integrations/git')
module('util/integrations/discord')

module('diagnostic/lsp_colours')
module('diagnostic/trouble')

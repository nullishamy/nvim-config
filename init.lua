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
module('core/statusline')

-- Neovide, if it exists
module('core/neovide')

-- Diagnostics and navigation
module('util/ui/tree')
module('diagnostic/lsp')

-- Snippets must be loaded before cmp
module('util/integrations/snippets')
module('diagnostic/cmp')

-- Plugins
module('util/autosave')
module('util/text/autopairs')
module('util/text/surround')
module('diagnostic/trouble')
module('util/text/comment')
module('util/navigation/leap')
module('treesitter')
module('util/integrations/git')
module('diagnostic/lsp_colours')
module('util/text/todo')
module('util/navigation/focus')
module('util/ui/gui')
module('util/navigation/scroll')
module('util/ui/terminal')
module('util/integrations/discord')
module('util/ui/quickfix')
module('util/filetype')

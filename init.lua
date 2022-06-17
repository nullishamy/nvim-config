-- Safely load modules, handling errors that arise during the load
function module(mod)
    local ok, res = pcall(require, mod)

    if not ok then
        vim.notify_once(string.format('Failed to load module %s | %s', mod, res))
    end
end

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

-- Diagnostics and navigation
module('util/tree')
module('diagnostic/lsp')

-- Snippets must be loaded before cmp
module('util/snippets')
module('diagnostic/cmp')

-- Plugins
module('util/autosave')
module('diagnostic/trouble')
module('util/comment')
module('util/leap')
module('treesitter')
module('diagnostic/lsp_colours')

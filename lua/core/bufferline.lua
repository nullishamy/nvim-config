require('bufferline').setup {
  options = {
    numbers = function()
        return ""
    end,
    modified_icon = "",
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    offsets = {
      { filetype = "NvimTree", text = "", padding = 1 },
      { filetype = "neo-tree", text = "", padding = 1 },
      { filetype = "Outline", text = "", padding = 1 },
    },
    show_buffer_icons = true, --| false, -- disable filetype icons for buffers
    show_buffer_close_icons = false,--| false,
    show_buffer_default_icon = true,
    show_close_icon = true,   --| false,
    show_tab_indicators = false, --| false,
    persist_buffer_sort = true,
    separator_style = "thin", --| "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false, --| true,
    always_show_bufferline = true, --| false,
    diagnostics = 'nvim_lsp'
  }
}

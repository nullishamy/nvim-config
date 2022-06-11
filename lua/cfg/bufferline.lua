require('bufferline').setup {
  options = {
    numbers = function()
        return ""
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left" --[[| "center" | "right",]]}},
    show_buffer_icons = true, --| false, -- disable filetype icons for buffers
    show_buffer_close_icons = false,--| false,
    show_close_icon = true,   --| false,
    show_tab_indicators = true, --| false,
    persist_buffer_sort = true,
    separator_style = "thick", --| "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false, --| true,
    always_show_bufferline = true, --| false,
  }
}

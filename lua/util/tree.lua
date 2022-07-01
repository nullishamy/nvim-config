require('nvim-tree').setup {
    update_cwd = true,
    view = {
        width = 35,
        adaptive_size = true
    },
    renderer = {
      highlight_opened_files = "1",
      group_empty = true,
      indent_markers = {
        enable = false,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },
    },
    actions = {
      change_dir = { enable = false },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    filters = {
      dotfiles = true,
      custom = { 'node_modules', '.cache', '.bin' },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = "H",
        info = "I",
        warning = "W",
        error = "E",
      },
    },
}

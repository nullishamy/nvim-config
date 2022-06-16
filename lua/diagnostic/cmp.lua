local present, cmp = pcall(require, "cmp")

if not present then
  return
end

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local cmp_window = require "cmp.utils.window"

function cmp_window:has_scrollbar()
  return false
end

local options = {
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
    },
    documentation = {
      border = border "CmpDocBorder",
    },
  },
  snippet = {
    expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end
  },
  formatting = {
    format = function(_, vim_item)
      local icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

      return vim_item
    end,
  },
  mapping = {
    ['<UP>'] = cmp.mapping.select_prev_item(),
    ['<DOWN>'] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Enter>"] = cmp.mapping.complete(),
    ["<ESC>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }
  },
   sources = {
     { name = "nvim_lsp" },
     { name = "luasnip" },
     { name = "buffer" },
     { name = "nvim_lua" },
     { name = "path" },
     { name = "emoji"},
     { name = "spell"},
    { name = "latex_symbols" },
  },
}


cmp.setup(options)

vim.diagnostic.config({
    virtual_text = false
})

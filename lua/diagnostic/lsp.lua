-- Init LSP installer
require("nvim-lsp-installer").setup {
    ui = {
        check_outdated_servers_on_open = false,
    }
}

local lsp = require("lspconfig")

local on_attach = function (_, buf)
    local opts = { noremap = true, silent = true }
    local set = vim.api.nvim_buf_set_keymap

    set(buf, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    set(buf, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    set(buf, 'n', '<C-Space>', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
    set(buf, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    set(buf, '', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    set(buf, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    set(buf, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    set(buf, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    set(buf, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    set(buf, 'n', '<leader>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
    set(buf, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    set(buf, '', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    set(buf, 'n', '<leader>ds', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
  tsserver = {},
  bashls = {},
  cssls = {},
  dockerls = {},
  jsonls = {},
  solargraph = {},
  rust_analyzer = {
	  cmd = {'rust-analyzer'},
  },
  pyright = {},
  clangd = {},
  kotlin_language_server = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.stdpath('config') .. '/lua'
          }
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  html = {},
}

for server, config in pairs(servers) do
  config.autostart = true
  config.on_attach = on_attach
  config.capabilities = capabilities
  lsp[server].setup(config)
end

require('rust-tools').setup {
  server = {
    autostart = true,
    on_attach = on_attach,
    capabilities = capabilities
  },
  tools = {
    autoSetHints = false,
    inlay_hints = {
        show_parameter_hints = false,
        show_variable_name = false,
        on_initialized = function()
            require('rust-tools.inlay_hints').disable_inlay_hints()
        end
    }
  }
}

local saga = require('lspsaga')

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}


-- Prettier
local null_ls = require("null-ls")
local prettier = require("prettier")

null_ls.setup({
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")
      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    end

    if client.resolved_capabilities.document_range_formatting then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})

prettier.setup({
  bin = 'prettier', -- or `prettierd`
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },

  -- prettier format options (you can use config files too. ex: `.prettierrc`)
  arrow_parens = "always",
  bracket_spacing = true,
  embedded_language_formatting = "auto",
  end_of_line = "lf",
  html_whitespace_sensitivity = "css",
  jsx_bracket_same_line = false,
  jsx_single_quote = false,
  print_width = 80,
  prose_wrap = "preserve",
  quote_props = "as-needed",
  semi = true,
  single_quote = false,
  tab_width = 2,
  trailing_comma = "es5",
  use_tabs = false,
  vue_indent_script_and_style = false,
})

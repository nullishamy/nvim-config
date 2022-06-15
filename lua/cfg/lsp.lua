local lsp = require("lspconfig")

local on_attach = function (_, buf)
    local opts = { noremap = true, silent = true }
    local set = vim.api.nvim_buf_set_keymap

    set(buf, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    set(buf, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    set(buf, 'n', '<C-Space>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    set(buf, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    set(buf, '', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    set(buf, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    set(buf, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    set(buf, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    set(buf, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    set(buf, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    set(buf, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    set(buf, '', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    set(buf, 'n', '<leader>ds', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
 -- TODO: Put the formatting step here  
    -- vim.cmd [[
	--  augroup fmt autocmd!
	--	  autocmd BufWritePre * undojoin | Neoformat
  	-- augroup END
 -- ]]
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

-- rust-tools
require('rust-tools').setup {
  server = {
    autostart = true,
    on_attach = on_attach,
    capabilities = capabilities
  }
}

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<UP>'] = cmp.mapping.select_prev_item(),
    ['<DOWN>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Enter>'] = cmp.mapping.complete(),
    ['<ESC>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
  	{ name = 'nvim_lsp' },
      	{ name = 'luasnip' },
      	{ name = 'path'},
	{ name = 'buffer'},
    	})
}

vim.diagnostic.config({
    virtual_text = false
})

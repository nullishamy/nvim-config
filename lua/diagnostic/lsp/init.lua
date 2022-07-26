-- Init LSP installer
require('nvim-lsp-installer').setup({
  ui = {
    check_outdated_servers_on_open = false,
  },
})

local util = require('diagnostic.lsp.util')

local servers = {
  null_ls = require('diagnostic.lsp.null-ls'),
  tsserver = require('diagnostic.lsp.tsserver'),
  bashls = require('diagnostic.lsp.bashls'),
  cssls = require('diagnostic.lsp.cssls'),
  dockerls = require('diagnostic.lsp.dockerls'),
  jsonls = require('diagnostic.lsp.jsonls'),
  rust_analyzer = require('diagnostic.lsp.rust_analyzer'),
  pyright = require('diagnostic.lsp.pyright'),
  clangd = require('diagnostic.lsp.clangd'),
  kotlin_language_server = require('diagnostic.lsp.kotlin_language_server'),
  sumneko_lua = require('diagnostic.lsp.sumneko_lua'),
  prismala = require('diagnostic.lsp.prismals'),
  html = require('diagnostic.lsp.html'),
}

local generate_on_attach = function(config)
  return function(client, buf)
    if (config.disable_formatting) then
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end

    util.common_on_attach(client, buf)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp = require('lspconfig')

for server, config in pairs(servers) do
  config.autostart = true
  config.capabilities = capabilities
  config.on_attach = generate_on_attach(config)

  if config.external_setup then
    config.external_setup(config)
  else
    lsp[server].setup(config)
  end

  if config.post_init then
    config.post_init(config)
  end
end

util.setup_lsp_borders()

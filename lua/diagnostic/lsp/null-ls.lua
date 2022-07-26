local null_ls = require('null-ls')

local SOURCES = {
  null_ls.builtins.formatting.stylua.with({
    condition = function(utils)
      return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
    end,
  }),
}

local function setup(config)
  local configs = require('lspconfig.configs')

  vim.cmd("command! NullLsInfo lua require('null-ls').null_ls_info()")
  vim.cmd("command! NullLsLog lua vim.fn.execute('edit ' .. require('null-ls.logger').get_path())")

  vim.cmd([[
    augroup NullLs
      autocmd!
        autocmd DirChanged * lua require('core.diagnostic.lsp.null_ls').on_dir_changed()
        autocmd FileType * lua require('core.diagnostic.lsp.null_ls').add_buf()
        autocmd InsertLeave * lua require("null-ls.rpc").flush()
    augroup end
  ]])

  null_ls.setup({
    sources = SOURCES,
    on_attach = config.on_attach,
  })

  configs['null-ls'] = {
    name = 'null-ls',
    default_config = {
      root_dir = function()
        vim.notify(vim.loop.cwd())
        return vim.loop.cwd()
      end,
    },
  }

  configs['null-ls'].launch = function()
    null_ls.reset_sources()
    null_ls.register(SOURCES)
    require('null-ls.client')._reset()
    require('null-ls.client').try_add()
  end
end

local function find_null_ls_client()
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == 'null-ls' then
      return client
    end
  end
  return nil
end

local function on_dir_changed()
  local client = find_null_ls_client()

  if client ~= nil then
    vim.cmd(string.format([[ LspStop %d ]], client.id))
    vim.wait(500, function()
      return find_null_ls_client() == nil
    end)
  end

  vim.cmd([[ LspStart null-ls ]])
end

local function add_buf()
  vim.wait(600, function()
    return find_null_ls_client() ~= nil
  end)

  require('null-ls.client').try_add()
end

return {
  external_setup = setup,
  on_dir_changed = on_dir_changed,
  add_buf = add_buf,
}

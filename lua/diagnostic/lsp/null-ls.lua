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
      autocmd DirChanged * unsilent LspStart null-ls
      autocmd InsertLeave * unsilent lua require("null-ls.rpc").flush()
    augroup end
  ]])

  null_ls.setup({
    sources = SOURCES,
    on_attach = config.on_attach,
    debug = true
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

return {
  external_setup = setup
}

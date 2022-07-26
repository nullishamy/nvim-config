local M = {}

function M.common_on_attach(_, buf)
  local opts = { noremap = true, silent = true }
  local set = vim.api.nvim_buf_set_keymap

  set(buf, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  set(buf, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  set(buf, 'n', '<C-Space>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  set(buf, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  set(buf, '', '<leader>i', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  set(buf, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  set(buf, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  set(buf, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  set(buf, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  set(buf, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  set(buf, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  set(buf, '', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  set(buf, '', '<leader>y', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
end

function M.setup_lsp_borders()
  local border = require('utils').border

  -- Configure borders
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = border('FloatBorder'),
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = border('FloatBorder'),
  })
end

return M

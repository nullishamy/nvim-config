local plenary = require('plenary')
local Path = plenary.path

local util = require('nvim-compile.util')
local log = require('nvim-compile.log')

local FTerm = require('FTerm')

local DEFAULT_OPTS = {
  data_path = Path:new(vim.fn.stdpath('data'), 'nvim-compile', 'data.json')
}

local M = {
  loaded = false,
  config = nil,
  data = nil
}

local function set_commands()
  vim.cmd('command! -nargs=? Compile unsilent lua require("nvim-compile").run("<args>")')
end

function M.setup(opts)
  if M.loaded then
    return
  end

  opts = plenary.tbl.apply_defaults(opts, DEFAULT_OPTS)

  M.config = opts
  util.init_persistence_data(opts)

  M.data = util.get_persistence_data(opts)

  set_commands()

  M.loaded = true
end

local function run_associated()
  local data = M.data
  assert(data, 'ran run_associated with nil data')

  local cur_buf = util.get_current_buf_path()

  if string.len(cur_buf) == 0 then
    cur_buf = 'unknown'
  end

  -- If the file doesnt exist, or the buffer is modified, we dont want to run
  if not Path:new(cur_buf):exists() or vim.bo.modified then
    return log.warn(string.format('cannot run compile command for an unsaved buffer (path: %s)', cur_buf))
  end

  for _,val in pairs(data) do
    if val.path == cur_buf then
      local cmd = val.cmd

      -- Double % to escape it for lua pattern matching
      cmd = string.gsub(cmd, '%%', cur_buf)

      FTerm.scratch({ cmd = cmd })
      return
    end
  end

  log.info('could not locate compile command for this file')
end

local function set_command(cmd)
  local data = M.data
  assert(data, 'ran set_command with nil data')

  local config = M.config
  assert(data, 'ran set_command with nil config')

  local path = util.get_current_buf_path()

  if string.len(path) == 0 then
    log.warn('cannot set compile command for an un-named buffer')
    return
  end

  table.insert(data, {
    path = path,
    cmd = cmd
  })

  util.save_persistence_data(config, data)
end

function M.run(...)
  if not M.loaded then
    return log.error('cannot `run` without calling `setup` first!')
  end

  -- Init here too, in case the file was deleted after `setup` was called
  util.init_persistence_data(M.config)

  local args = { ... }

  local next = next(args)

  -- If there's no args, we get passed an empty string
  if next == nil or string.len(args[next]) == 0 then
    -- Run the associated command, no command was passed
    run_associated()
  else
    -- Set the command based on the args
    -- `args` should be all strings, no need to convert to strings
    set_command(table.concat(args, ' '))
  end
end


return M

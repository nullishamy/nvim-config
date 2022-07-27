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

local function get_entry(path)
  local data = M.data
  assert(data, 'ran get_entry with nil data')

  for _,val in pairs(data) do
    if val.path == path then
      return val
    end

    return nil
  end
end

local function run_associated()
  local cur_buf = util.get_current_buf_path()

  if string.len(cur_buf) == 0 then
    cur_buf = 'unknown'
  end

  -- If the file doesnt exist, or the buffer is modified, we dont want to run
  if not Path:new(cur_buf):exists() or vim.bo.modified then
    return log.warn(string.format('cannot run compile command for an unsaved buffer (path: %s)', cur_buf))
  end

  local val = get_entry(cur_buf)

  if val == nil then
    return log.info('could not locate compile command for this file')
  end

  -- Double % to escape it for lua pattern matching
  local cmd = string.gsub(val.cmd, '%%', cur_buf)

  FTerm.scratch({ cmd = cmd })
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

  local val = get_entry(path)
  local exists = val == nil
  local should_update = false

  if exists then
    should_update = vim.fn.input('a command already exists for this buffer, do yo want to override it? [y/N]') == 'y'
  end

  if should_update then
    assert(exists, 'entry did not exist')
    assert(val, 'entry did not exist')

    val.cmd = cmd
  else
    table.insert(data, {
      path = path,
      cmd = cmd
    })
  end

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

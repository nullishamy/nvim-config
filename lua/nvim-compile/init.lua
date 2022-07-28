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

  -- Not prefixed with compile to allow for shortcuts
  vim.cmd('command! ViewCommands unsilent lua require("nvim-compile").view()')

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

local function prompt_value(prompt, on_select)
  assert(on_select, 'on_select was not set')
  assert(prompt, 'prompt was not set')
  assert(M.data, 'data was not set when calling `prompt_value`')

  -- tbl_values converts from an arbitrary indexable type to a table that select() requires
  vim.ui.select(vim.tbl_values(M.data), {
    prompt = prompt,
    format_item = function(item)
      -- Remove the workspace portion from the file path
      -- + 2, 1 indexing & cut the leading slash
      return string.format('%s (%s)', item.workspace, string.sub(item.path, string.len(item.workspace) + 2))
    end,
  }, on_select)
end

function M.view()
  if not M.loaded then
    return log.error('cannot `view` without calling `setup` first!')
  end

  assert(M.config, 'config was not set when calling `view`')
  util.init_persistence_data(M.config)

  local action_prompt = {
    prompt = 'what would you like to do? [(d)elete, v(iew)] '
  }

  local actions = {
    d = function(val, index)
      table.remove(M.data, index)
      util.save_persistence_data(M.config, M.data)
      log.info(string.format('removed command for %s %s', val.type == 'workspace' and 'workspace' or 'buffer',
        val.type == 'workspace' and val.workspace or val.path))
    end,
    v = function(val)
      local Window = require('plenary.window.float')

      local function center(str, bufnr)
        local width = vim.api.nvim_win_get_width(bufnr)
        local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
        return string.rep(' ', shift) .. str
      end

      -- No border
      local window = Window.percentage_range_window(0.25, 0.25, {}, { border_thickness = { top = 0, right = 0, bot = 0, left = 0 } })

      vim.api.nvim_buf_set_lines(window.bufnr, 0, -1, false, {
        '',
        center('path:', window.win_id),
        center(val.path, window.win_id),
        '',
        center('workspace:', window.win_id),
        center(val.workspace, window.win_id),
        '',
        center('cmd:', window.win_id),
        center(val.cmd, window.win_id),
        '',
        center('type:', window.win_id),
        center(val.type, window.win_id),
        ''
      })
    end
  }

  prompt_value('Commands', function(val, index)
    if index == nil then
      return
    end

    vim.ui.input(action_prompt, function(input)
      if input == nil then
        return
      end

      if not vim.tbl_contains({ 'd', 'v' }, input) then
        -- Just no-op, its the easiest way to handle invalid input
        return
      end

      actions[input](val, index)
    end)

  end)
end

local function get_entry(path, is_workspace)
  local data = M.data
  assert(data, 'ran get_entry with nil data')

  for _, val in pairs(data) do
    if is_workspace and val.workspace == path then
      return val
    else if val.path == path then
        return val
      end
    end
  end

  return nil
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

  local workspace = vim.fn.getcwd()
  -- Prioritise per-file commands, or fall back to the workspace
  local val = get_entry(cur_buf, false) or get_entry(workspace, true)

  if val == nil then
    return log.info('could not locate compile command for this file or workspace')
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

  local workspace = vim.fn.getcwd()

  local should_set_workspace_prompt = {
    prompt = 'would you like to set this command for the workspace, or just the file? [W/f] '
  }

  vim.ui.input(should_set_workspace_prompt, function(input)
    if input == nil then
      return
    end

    local should_set_workspace = input == 'w'
    local val = get_entry(should_set_workspace and workspace or path, should_set_workspace)
    local exists = val ~= nil

    if exists then
      local command_exists_prompt = {
        prompt = string.format(
          'a command already exists for this %s, do you want to override it? [y/N] ',
          should_set_workspace and 'workspace' or 'buffer'
        )
      }

      vim.ui.input(command_exists_prompt, function(command_input)
        if command_input == nil then
          return
        end

        local should_update = command_input == 'y'

        if should_update then
          assert(exists, 'entry did not exist (exists)')
          assert(val, 'entry did not exist (val)')

          val.cmd = cmd

          return
        end
      end)

      return
    end


    -- If it doesn't exist, set it
    table.insert(data, {
      path = path,
      cmd = cmd,
      -- Set the workspace regardless, we need to know for the checks above
      workspace = workspace,
      type = should_set_workspace and 'workspace' or 'file'
    })

    util.save_persistence_data(config, data)
  end)
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

---@class Datastore
Datastore = {
}

local Path = require('plenary.path')

function Datastore:new(config)
  self.path = config.path
  self.data = { }
end

function Datastore:init()
  local path = self:path()

  if not path:exists() then
    path:touch({ parents = path:parents() })
    path:write('[]', 'w')
  end
end

function Datastore:path()
  return Path:new(self.path)
end

function Datastore:read()
  local path = self:path()
  local data = vim.json.decode(path:read())

  return data
end

function Datastore:write()
  local path = self:path()
  local json = vim.json.encode(self.data)

  path:write(json, 'w')
end

return Datastore

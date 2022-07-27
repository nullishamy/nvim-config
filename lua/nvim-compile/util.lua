local M = {}

local Path = require('plenary.path')

function M.get_persistence_path(config)
    return Path:new(config.data_path)
end

function M.get_current_buf_path()
    return vim.fn.expand('%:p')
end

function M.get_persistence_data(config)
    local path = M.get_persistence_path(config)
    local data = vim.json.decode(path:read())

    return data
end

function M.save_persistence_data(config, data)
    local path = M.get_persistence_path(config)
    local json = vim.json.encode(data)

    path:write(json, 'w')
end

function M.init_persistence_data(config)
    local path = M.get_persistence_path(config)

    if not path:exists() then
        path:touch({ parents = path:parents() })
        path:write('{}', 'w')
    end
end

return M

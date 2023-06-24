local M = {}
local Job = require("plenary.job")

M.run_os_cmd = function(cmd, cwd)
    if type(cmd) ~= "table" then
        print('cmd has to be a table')
        return {}
    end
    local command = table.remove(cmd, 1)
    local stderr = {}
    local stdout, ret = Job:new({ command = command, args = cmd, cwd = cwd, on_stderr = function(_, data)
        table.insert(stderr, data)
    end }):sync()
    return stdout, ret, stderr
end


return M

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

---@param content string
function M.CopyToSystemClipboard(content)
  local copy_cmd = 'pbcopy'
  -- Copy the absolute path to the clipboard
  if vim.fn.has('mac') or vim.fn.has('macunix') then
    copy_cmd = 'pbcopy'
  elseif vim.fn.has('win32') or vim.fn.has('win64') then
    copy_cmd = 'clip'
  elseif vim.fn.has('unix') then
    copy_cmd = 'xclip -selection clipboard'
  else
    print('Unsupported operating system')
    return
  end

  vim.fn.system(copy_cmd, content)
end


return M

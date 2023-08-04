---@meta
local M = {}

---@class EasyCommand.Command
---@field name string
---@field callback string | fun():nil
---@field description string?
---@field dependencies? string[]
---@field allow_visual_mode? boolean
---@field errorInfo? string
M.Command = {}

---@param t table
---@return boolean
function M.isCommand(t)
  if type(t) ~= "table" then
    return false
  end

  return t.name ~= nil and t.callback ~= nil
end

return M

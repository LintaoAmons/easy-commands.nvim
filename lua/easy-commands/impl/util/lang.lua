local editor = require("easy-commands.impl.util.editor")
local M = {}

---@functionName string
M.CallLanguageSpecificFunc = function(functionName)
  require("easy-commands.impl.lang." .. editor.getFiletype())[functionName]()
  -- local ok, _ = pcall(require("easy-commands.impl.lang." .. editor.getFiletype())[functionName])
  -- if not ok then
  --   vim.notify("There's some error or may not be implemented yet for [" .. editor.getFiletype() .. "] type")
  -- end
end
return M

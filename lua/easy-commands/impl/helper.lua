local M = {}
local lang = require("easy-commands.impl.util.lang")

M.PrintSelected = function()
  lang.CallLanguageSpecificFunc("PrintSelected")
end

return M

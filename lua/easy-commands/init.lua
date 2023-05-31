local M = {}

M.Setup = function(config)
  require('easy-commands.config').setup(config)
end

M.CheckConfig = function()
  vim.print(require("easy-commands.config"))
end

return M

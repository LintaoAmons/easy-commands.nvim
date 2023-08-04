local M = {}

M.setup = function(config)
	require("easy-commands.config").setup(config)
end

M.checkConfig = function()
	vim.print(require("easy-commands.config"))
end

return M

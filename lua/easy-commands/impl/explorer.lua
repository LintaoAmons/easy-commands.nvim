---@type EasyCommand.Command[]
local M = {
	{
		name = "ToggleExplorer",
		callback = function()
			vim.notify("Neo-tree's command can't be wrapped in this plugin, please use neo-tree directly")
		end,
	},
}

return M

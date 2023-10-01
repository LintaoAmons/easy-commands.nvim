---@type EasyCommand.Command[]
local M = {
	{
		name = "ToggleDebugUI",
		callback = function()
			require("dapui").toggle({})
		end,
		dependencies = { "https://github.com/mfussenegger/nvim-dap" },
		description = "toggle debug UI",
	},
}

return M

---@type EasyCommand.Command[]
local M = {
	{
		name = "ShowLineDiagnostics",
		callback = "Lspsaga show_line_diagnostics",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
	},

	{
		name = "Wrap",
		callback = "set wrap",
	},

	{
		name = "UnWrap",
		callback = "set unwrap",
	},
}

return M

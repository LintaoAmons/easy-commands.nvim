---@type EasyCommand.Command[]
local M = {
	{
		name = "ShowLineDiagnostics",
		callback = "Lspsaga show_line_diagnostics",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
		description = "Show diagnoestics of current line",
	},
	{
		name = "Wrap",
		callback = "set wrap",
	},

	{
		name = "UnWrap",
		callback = "set unwrap",
	},
	
	{
		name = "CodeActions",
		callback = "Lspsaga code_action",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
		description = "Show available code actions",
	},
}

return M

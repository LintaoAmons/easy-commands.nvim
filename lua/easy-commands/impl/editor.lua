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
	{
		name = "InspectCommand",
		callback = function()
			local commands = require("easy-commands.impl")
			local names = {}
			for _, c in ipairs(commands) do
				table.insert(names, c.name)
			end

			vim.ui.select(names, {
				prompt = "Command Name: ",
			}, function(cmdName)
				local editor = require("easy-commands.impl.util.editor")
				local string = require("easy-commands.impl.util.base.strings")
				local result = vim.api.nvim_exec2("verb command " .. cmdName, { output = true })
				local content = string.splitIntoLines(result.output)
				editor.splitAndWrite(content, { vertical = true })
			end)
		end,
	},
}

return M

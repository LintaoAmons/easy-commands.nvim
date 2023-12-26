---@type EasyCommand.Command[]
local M = {
	{
		name = "SourceCurrentBuffer",
		callback = "source %",
	},
	{
		name = "CheckKeymapDefinitions",
		callback = function()
			local editor = require("easy-commands.impl.util.editor")
			local string = require("easy-commands.impl.util.base.strings")
			local result = vim.api.nvim_exec2("verbose map", { output = true })
			local content = string.splitIntoLines(result.output)
			editor.split_and_write(content, { vertical = true })
		end,
		description = "Show all the keymaps and show the location of definition\n"
			.. "Can help you to debug keymap configuration",
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
				if not cmdName or cmdName == "" then
					return
				end
				local editor = require("easy-commands.impl.util.editor")
				local string = require("easy-commands.impl.util.base.strings")
				local result = vim.api.nvim_exec2("verb command " .. cmdName, { output = true })
				local content = string.splitIntoLines(result.output)
				editor.split_and_write(content, { vertical = true })
			end)
		end,
		description = "Inspect the commands that provided by easy-commands plugin",
	},
}

return M

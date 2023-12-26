---@type EasyCommand.Command[]
local M = {
	{
		name = "ToggleExplorer",
		callback = function()
			vim.notify("Neo-tree's command can't be wrapped in this plugin, please use neo-tree directly")
		end,
	},
	{
		name = "OpenInFinder",
		description = "Open the directory of current file in finder",
		callback = function()
			local dirpath = require("easy-commands.impl.util.editor").buf.read.get_buf_abs_dir_path()
			vim.cmd("!open " .. dirpath)
		end,
	},
	{
		name = "OpenBySystemDefaultApp",
		description = "Open the current file by system default app",
		callback = function()
			local abspath = require("easy-commands.impl.util.editor").buf.read.get_buf_abs_path()
			vim.cmd("!open " .. abspath)
		end,
	},
}

return M

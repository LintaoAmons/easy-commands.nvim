local util = require("easy-commands.impl.util")
local editor = require("easy-commands.impl.util.editor")
local strings = require("easy-commands.impl.util.base.strings")

---@type EasyCommand.Command[]
local M = {
	{
		name = "RunCurrentBuffer",
		callback = "%SnipRun",
		dependencies = { "https://github.com/michaelb/sniprun" },
	},
	{
		name = "RunLiveToggle",
		callback = "SnipLive",
		dependencies = { "https://github.com/michaelb/sniprun" },
	},
	{
		name = "RunCurrentLineAndOutput",
		callback = function()
			local currentLine = vim.api.nvim_get_current_line()
			local output = util.Call_sys_cmd(currentLine)
			util.CopyToSystemClipboard("\n" .. output)
			vim.cmd("silent! normal! $p")
		end,
	},
	{
		name = "RunCurrentLineAndOutputWithPrePostFix",
		callback = function()
			local currentLine = vim.api.nvim_get_current_line()
			local config = require("easy-commands.config").getConfig()
			local prefix = config.RunCurrentLineAndOutputWithPrePostFix.prefix
			local postfix = config.RunCurrentLineAndOutputWithPrePostFix.postfix
			local output = util.Call_sys_cmd(currentLine)
			util.CopyToSystemClipboard("\n" .. prefix .. "\n" .. strings.trim(output) .. "\n" .. postfix)
			vim.cmd("silent! normal! $p")
		end,
	},
	{
		name = "RunSelectedAndOutput",
		callback = function()
			local selectedText = editor.getSelectedText()
			local output = util.Call_sys_cmd(selectedText)
			util.CopyToSystemClipboard("\n" .. output)
			util.ExitCurrentMode()
			vim.cmd("silent! normal! $p")
		end,
		allow_visual_mode = true,
	},
	{
		name = "RunSelectedAndReplace",
		callback = function()
			local selectedText = editor.getSelectedText()
			local output = util.Call_sys_cmd(selectedText)
			util.CopyToSystemClipboard(strings.trim(output))
			editor.replaceSelectedTextWithClipboard()
		end,
		allow_visual_mode = true,
	},
	{
		name = "RunSelectedAndOutputWithPrePostFix",
		callback = function()
			local selectedText = editor.getSelectedText()
			local output = util.Call_sys_cmd(selectedText)
			local config = require("easy-commands.config").getConfig()
			local prefix = config.RunSelectedAndOutputWithPrePostFix.prefix
			local postfix = config.RunSelectedAndOutputWithPrePostFix.postfix
			util.CopyToSystemClipboard("\n" .. prefix .. "\n" .. strings.trim(output) .. "\n" .. postfix)
			util.ExitCurrentMode()
			vim.cmd("silent! normal! $p")
		end,
		allow_visual_mode = true,
	},
	-- {
	-- 	name = "RunCmd",
	-- 	callback = function()
	-- 		-- TODO: implement the functionality
	-- 	end,
	-- },
	-- {
	-- 	name = "QueryCsv",
	-- 	callback = function()
	-- 		local filename = GetFilename()
	-- 		local sql = editor.getCurrentLine()
	-- 		sql = util.ReplacePattern(sql, "from fj", "from `" .. filename .. "`")
	-- 		sql = util.ReplacePattern(sql, "from jf", "from `" .. filename .. "`")
	-- 		local cmd = "csvq '" .. sql .. "'"
	-- 		local result = util.Call_sys_cmd(cmd) or ""
	-- 		local output_lines = vim.split(result, "\n")
	-- 		for i = #output_lines, 1, -1 do
	-- 			if output_lines[i] == "" then
	-- 				table.remove(output_lines, i)
	-- 			end
	-- 		end
	-- 		editor.PutLines(output_lines, "l", true, true)
	-- 	end,
	-- },
}

return M

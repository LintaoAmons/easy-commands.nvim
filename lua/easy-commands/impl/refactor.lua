local util = require("easy-commands.impl.util")
local editor = require("easy-commands.impl.util.editor")
local strings = require("easy-commands.impl.util.base.strings")
local tables = require("easy-commands.impl.util.base.table")

-- cmdFunc could do some trick to the selectedText
local function performCmdToSeletedText(cmdFunc)
	local selectedText = editor.getSelectedText()
	local output = util.Call_sys_cmd(cmdFunc(selectedText))
	util.CopyToSystemClipboard(strings.trim(output))
	editor.replaceSelectedTextWithClipboard()
end

-- Third party dependency

---@type EasyCommand.Command[]
local M = {
	{
		name = "Rename",
		callback = "Lspsaga rename",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
	},
	{
		name = "InlineVariable",
		callback = function()
			require("refactoring").refactor("Inline Variable")
		end,
		dependencies = { "ThePrimeagen/refactoring.nvim" },
	},
	{
		name = "ExtractVariable",
		callback = function()
			require("refactoring").refactor("Extract Variable")
		end,
		dependencies = { "ThePrimeagen/refactoring.nvim" },
	},
	{
		name = "ExtractFunction",
		callback = function()
			require("refactoring").refactor("Extract Function")
		end,
		dependencies = { "ThePrimeagen/refactoring.nvim" },
	},
	{
		name = "ToNextCase",
		callback = function()
			if vim.g.easy_command_next_case == nil then
				vim.g.easy_command_next_case = "ToCamelCase"
			end
			M[vim.g.easy_command_next_case].callback()
			local cases = { "ToCamelCase", "ToConstantCase", "ToKebabCase", "ToSnakeCase" }
			vim.g.easy_command_next_case = cases[tables.findIndex(cases, vim.g.easy_command_next_case) + 1]
		end,
		dependencies = { "https://github.com/LintaoAmons/ltoolbox" },
	},
	{
		name = "ToCamelCase",
		callback = function()
			performCmdToSeletedText(function(selectedText)
				return 'toolbox formatConvert toCamelCase "' .. selectedText .. '"'
			end)
		end,
		allow_visual_mode = true,
		dependencies = { "https://github.com/LintaoAmons/ltoolbox" },
	},
	{
		name = "ToConstantCase",
		callback = function()
			performCmdToSeletedText(function(selectedText)
				return 'toolbox formatConvert toConstantCase "' .. selectedText .. '"'
			end)
		end,
		allow_visual_mode = true,
		dependencies = { "https://github.com/LintaoAmons/ltoolbox" },
	},
	{
		name = "ToKebabCase",
		callback = function()
			performCmdToSeletedText(function(selectedText)
				return 'toolbox formatConvert ToKebabCase "' .. selectedText .. '"'
			end)
		end,
		allow_visual_mode = true,
		dependencies = { "https://github.com/LintaoAmons/ltoolbox" },
	},
	{
		name = "ToSnakeCase",
		callback = function()
			performCmdToSeletedText(function(selectedText)
				return 'toolbox formatConvert toSnakeCase "' .. selectedText .. '"'
			end)
		end,
		allow_visual_mode = true,
		dependencies = { "https://github.com/LintaoAmons/ltoolbox" },
	},
}

return M

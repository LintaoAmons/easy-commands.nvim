---@type EasyCommand.Command[]
M = {
	{
		name = "AskGpt4",
		callback = function()
			require("scratch").scratchByType("gp.md")
		end,
		dependencies = {
			"https://github.com/robitx/gp.nvim",
			"https://github.com/LintaoAmons/scratch.nvim",
		},
		description = "Ask chatgpt in vim and stored in scratchfile's directory",
	},
}

return M

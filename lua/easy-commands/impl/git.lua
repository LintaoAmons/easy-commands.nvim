---@type EasyCommand.Command[]
local M = {
	{
		name = "Git",
		callback = "Neogit",
		dependencies = { "https://github.com/NeogitOrg/neogit" },
	},
	{
		name = "GitDiff",
		callback = "DiffviewOpen",
		dependencies = { "https://github.com/sindrets/diffview.nvim" },
	},
	{
		name = "GitStatus",
		callback = "Telescope git_status",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	},
	{
		name = "GitStash",
		callback = "!git stash",
	},
	{
		name = "GitStashPop",
		callback = "!git stash pop",
	},
	{
		name = "GitPush",
		callback = "!git push",
	},
	{
		name = "GitCommit",
		callback = function()
			vim.ui.input({ prompt = "Commit msg: " }, function(msg)
				local sys = require("easy-commands.impl.util.base.sys")
				local stdout, _, stderr = sys.run_os_cmd({ "git", "commit", "-m", msg }, ".")
				if stderr then
					vim.print(stderr) -- TODO: move log in config module to util module and use it here
				else
					vim.print(stdout)
				end
			end)
		end,
    description = "Commit current staged changes with commit msg"
	},
	{
		name = "GitListCommits",
		callback = "DiffviewFileHistory",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	},
	{
		name = "GitListCommitsOfCurrentFile",
		callback = "DiffviewFileHistory %",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	},
	{
		name = "GitNextHunk",
		callback = "lua require 'gitsigns'.next_hunk({navigation_message = false})",
		dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
	},
	{
		name = "GitPrevHunk",
		callback = "lua require 'gitsigns'.prev_hunk({navigation_message = false})",
		dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
	},
	{
		name = "GitResetHunk",
		callback = "lua require 'gitsigns'.reset_hunk()",
		dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
	},
	{
		name = "GitListBranches",
		callback = "Telescope git_branches",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	},
	{
		name = "GitBlameLine",
		callback = "lua require 'gitsigns'.blame_line()",
		dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
	},
	{
		name = "GitResetBuffer",
		callback = "lua require 'gitsigns'.reset_buffer()",
		dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
	},
}

return M

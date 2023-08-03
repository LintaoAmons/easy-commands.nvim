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
	-- M.GitCommit = TODO:
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

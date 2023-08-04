---@type EasyCommand.Command[]
local M = {
	{
		name = "FindFiles",
		callback = "Telescope find_files",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
		description = "find files in project scope",
	},
	{
		name = "FindCommands",
		callback = "Telescope commands",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	},
	{
		name = "FindKeymappins",
		callback = "Telescope keymaps",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	},
	{
		name = "FindInProject",
		callback = "Telescope live_grep",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
		allow_visual_mode = true,
		description = "find content inside the project scope",
	},
	{
		name = "SearchInProject",
		callback = "Telescope live_grep",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
		allow_visual_mode = true,
		description = "search content inside the project scope",
	},
	{
		name = "SearchOrReplace",
		callback = function()
			require("spectre").open_visual()
		end,
		dependencies = { "https://github.com/nvim-pack/nvim-spectre" },
		allow_visual_mode = true,
		description = "search or replace pattern in whole project",
	},
}

return M

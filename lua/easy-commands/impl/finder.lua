---@type EasyCommand.Command[]
local M = {
	{
		name = "FindFiles",
		callback = "Telescope find_files",

		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
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
	},
	{
		name = "SearchInProject",
		callback = "Telescope live_grep",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
		allow_visual_mode = true,
	},
	{
		name = "SearchOrReplace",
		callback = function()
			require("spectre").open_visual()
		end,
		dependencies = { "https://github.com/nvim-pack/nvim-spectre" },
		allow_visual_mode = true,
	},
}

return M

local M = {}

M.FindFiles = "Telescope find_files"
M.FindCommands = "Telescope commands"
M.FindKeymappins = "Telescope keymaps"
M.FindInProject = {
	callback = "Telescope live_grep",
	allow_visual_mode = true,
}
M.SearchInProject = M.FindInProject

M.SearchOrReplace = {
	callback = function()
		require("spectre").open_visual()
	end,
	allow_visual_mode = true,
}

M.FzfLuaBuiltin = 'lua require("fzf-lua").builtin()'

return M

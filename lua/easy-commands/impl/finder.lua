local M = {}

M.FindFiles = 'FzfLua files'
M.FindCommands = 'FzfLua commands'
M.FindKeymappins = 'FzfLua keymaps'
M.FindInProject = {
  callback = "FzfLua grep_project",
  allow_visual_mode = true,
}
M.SearchInProject = M.FindInProject

M.SearchOrReplace = {
  callback = function()
    require("spectre").open_visual()
    require('spectre').change_options('ignore-case')
    require('spectre').change_options('hidden')
  end,
  allow_visual_mode = true,
}

M.FzfLuaBuiltin = 'lua require("fzf-lua").builtin()'

return M

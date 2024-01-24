local function find_commands()
  -- TODO: recent commands
  -- local recent_commands = vim.g.easy_command_recent_commands or {}
  local commands = vim.api.nvim_get_commands({})

  local commandList = {}
  local maxLength = 0
  for name, value in pairs(commands) do
    if #name > maxLength then
      maxLength = #name
    end
    -- if vim.tbl_contains(commandList, value)
    table.insert(commandList, value)
  end

  vim.ui.select(commandList, {
    prompt = "Commands",
    format_item = function(command)
      local name = string.format("%-" .. maxLength .. "s", command.name)
      return name .. " | " .. command.definition
    end,
    telescope = require("telescope.themes"),
  }, function(command)
    if not command then
      return
    end
    vim.api.nvim_exec2(command.name, {})
  end)
end

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
    callback = find_commands,
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
  {
    name = "SearchOrReplaceInCurrentFile",
    callback = "lua require('spectre').open_file_search({select_word=true})",
    dependencies = { "https://github.com/nvim-pack/nvim-spectre" },
    description = "Search or replace the word in current file",
    allow_visual_mode = true,
  },
}

return M

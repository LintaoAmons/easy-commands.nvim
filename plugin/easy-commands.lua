if vim.fn.has("nvim-0.7.0") == 0 then
  vim.api.nvim_err_writeln("scratch requires at least nvim-0.7.0.1")
  return
end

-- make sure this file is loaded only once
if vim.g.loaded_easy_commands == 1 then
  return
end
vim.g.loaded_easy_commands = 1

local commands_name = require("easy-commands.names")
local impl = require("easy-commands.impl")

for _, command in pairs(commands_name) do
  local implementation = impl[command]

  if not implementation then
    vim.api.nvim_create_user_command(command, "lua = vim.notify('No implementation yet')", {})
    goto continue
  end

  if type(implementation) == "function" or type(implementation) == "string" then
    vim.api.nvim_create_user_command(command, implementation, {})
    goto continue
  end

  if type(implementation) == "table" then
    if implementation.allow_visual_mode then
      -- https://github.com/ray-x/go.nvim/blob/711b3b84cf59d3c43a9d1b02fdf12152b397e7b1/lua/go/commands.lua#LL443C7-L443C20
      vim.api.nvim_create_user_command(command, implementation.callback, { range = true })
      goto continue
    end
  end

  ::continue::
end

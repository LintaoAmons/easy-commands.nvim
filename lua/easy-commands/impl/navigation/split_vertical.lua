local M = {}
function M.toggle_two_split_mode()
  if vim.g.eacy_command_two_split_mode == nil then
    vim.g.eacy_command_two_split_mode = false
  end

  if vim.g.eacy_command_two_split_mode then
    vim.g.eacy_command_two_split_mode = false
  else
    vim.g.eacy_command_two_split_mode = true
  end

  print("Two Split Mode is now " .. (vim.g.eacy_command_two_split_mode and "enabled" or "disabled"))
end

function M.easy_command_split()
  if vim.g.eacy_command_two_split_mode == true then
    require("easy-commands.impl.util.editor").window.close_all_other_windows({
      "filesystem",
      "Trouble",
    })
  end
  vim.cmd("rightbelow vsplit")
end

return M

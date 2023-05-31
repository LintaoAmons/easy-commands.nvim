local M = {}
local util = require("easy-commands.impl.util")

M.GoToTestFile = function()
  local test_suffix = "_test.go"
  local current_file = vim.fn.expand("%:p")

  local jump_to_file
  if util.EndsWithSuffix(current_file, test_suffix) then
    jump_to_file = util.ReplacePattern(current_file, test_suffix, ".go")
  else
    jump_to_file = vim.fn.expand("%:p:r") .. test_suffix
  end

  if vim.fn.filereadable(jump_to_file) == 0 then
    local create_cmd = "silent execute '!touch " .. jump_to_file .. "'"
    vim.cmd(create_cmd)
  end

  vim.cmd("e " .. jump_to_file)
end

return M

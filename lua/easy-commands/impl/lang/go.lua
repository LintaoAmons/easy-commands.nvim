local M = {}
local util = require("easy-commands.impl.util")
local strings = require("easy-commands.impl.util.base.strings")

M.GoToTestFile = function()
  local test_suffix = "_test.go"
  local current_file = vim.fn.expand("%:p")

  local jump_to_file
  if strings.EndsWithSuffix(current_file, test_suffix) then
    jump_to_file = strings.ReplacePattern(current_file, test_suffix, ".go")
  else
    jump_to_file = vim.fn.expand("%:p:r") .. test_suffix
  end

  if vim.fn.filereadable(jump_to_file) == 0 then
    require("easy-commands.impl.util.base.fs").createFile(jump_to_file)
  end

  vim.cmd("e " .. jump_to_file)
end

return M

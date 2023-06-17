local editor = require("easy-commands.impl.util.editor")
local tableUtil = require("easy-commands.impl.util.base.table")
local M = {}

M.PrintSelected = function()
  vim.print("called")
  local selected = vim.fn.split(editor.getSelectedText(), "\n")
  local content = {}
  local length = tableUtil.tableLength(selected)
  vim.print("length: " .. length)
  if length > 1 then
    for index, value in ipairs(selected) do
      if index == 1 then
        table.insert(content, "vim.print(" .. value)
      elseif index == length then
        table.insert(content, value .. ")")
      else
        table.insert(content, value)
      end
    end
  elseif length == 1 then
    table.insert(content, "vim.print(" .. selected[1] .. ")")
  else
    table.insert(content, "vim.print('No content detected')")
  end
  vim.print(content)

  local current_buf = vim.api.nvim_get_current_buf()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  vim.print({ csrow, cscol, cerow, cecol })

  vim.api.nvim_buf_set_lines(current_buf, csrow, cerow, false, content)
  -- vim.api.nvim_buf_set_text(current_buf, csrow, cscol+1, cerow, cecol+1, content)
end

return M

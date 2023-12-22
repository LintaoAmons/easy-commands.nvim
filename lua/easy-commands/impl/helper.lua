-- Function to insert a line above and below the current line
function CodeBlock()
  -- Get the current buffer and cursor position
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_num = cursor[1]

  -- Lines to be inserted
  local new_lines_above = { "```" } -- Insert an empty line above
  local new_lines_below = { "```" } -- Insert an empty line below

  -- Insert a line above the current line
  vim.api.nvim_buf_set_lines(buf, line_num - 1, line_num - 1, false, new_lines_above)
  -- Adjust line number for insertion below, since we added a line above
  line_num = line_num + 1
  -- Insert a line below the current line
  vim.api.nvim_buf_set_lines(buf, line_num, line_num, false, new_lines_below)
end

---@type EasyCommand.Command[]
local M = {
  {
    name = "PrintSelected",
    callback = function()
      local lang = require("easy-commands.impl.util.lang")
      lang.CallLanguageSpecificFunc("PrintSelected")
    end,
  },
  {
    name = "MarkdownCodeBlock",
    callback = CodeBlock,
  },
}

return M

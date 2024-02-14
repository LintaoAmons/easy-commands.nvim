local editor = require("easy-commands.impl.util.editor")

function code_block()
  local positions = editor.selections.get_positions()
  local start_position = positions[1]
  local end_position = positions[2]

  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()

  local marker = { "```" }

  vim.api.nvim_buf_set_lines(
    buf,
    start_position.row - 1,
    start_position.row - 1,
    false,
    marker
  )
  vim.api.nvim_buf_set_lines(
    buf,
    end_position.row + 1,
    end_position.row + 1,
    false,
    marker
  )
  vim.api.nvim_win_set_cursor(win, { start_position.row, 0 })
  vim.api.nvim_input("A")
end

---@type EasyCommand.Command[]
local M = {
  {
    name = "PrintSelected",
    callback = function()
      local lang = require("easy-commands.impl.util.lang")
      lang.call_language_specific_func("PrintSelected")
    end,
  },
  {
    name = "MarkdownCodeBlock",
    callback = code_block,
    allow_visual_mode = true,
  },
}

return M

local M = {}
local harpoonMark = require("harpoon.mark")
local leap = require("leap")

M.OpenChangedFiles = "FzfLua git_status"
M.OpenRecentFiles = 'FzfLua oldfiles'

M.LeapJump = function()
  leap.leap {
    target_windows = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    ),
  }
end

M.MaximiseBuffer = function()
  -- Get the current buffer number
  local current_bufnr = vim.api.nvim_get_current_buf()

  -- Create a new tab and switch to it
  vim.api.nvim_command('tabnew')

  -- Get the new tab's buffer number
  local new_bufnr = vim.api.nvim_get_current_buf()

  -- Copy the contents of the current buffer to the new buffer
  vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, vim.api.nvim_buf_get_lines(current_bufnr, 0, -1, false))

  -- Set the file type of the new buffer to match the current buffer
  vim.api.nvim_buf_set_option(new_bufnr, 'filetype', vim.api.nvim_buf_get_option(current_bufnr, 'filetype'))

  -- Set the modified flag of the new buffer to match the current buffer
  vim.api.nvim_buf_set_option(new_bufnr, 'modified', vim.api.nvim_buf_get_option(current_bufnr, 'modified'))

  -- Switch back to the original buffer in the new tab
  vim.api.nvim_set_current_buf(current_bufnr)
end

M.TabNext = "tabnext"
M.TabPrev = "tabprevious"
M.TabClose = "tabclose"
M.TabNew = "tabnew"

M.BufferNext = "BufferLineCycleNext"

M.BufferPrev = "BufferLineCyclePrev"

M.SplitVertically = 'vsplit'

M.MaximiseBufferAndCloseOthers = function()
  -- TODO:
  vim.notify("TODO")
end

M.IncreaseSplitWidth = 'vertical resize +5'

M.DecreaseSplitWidth = 'vertical resize -5'

M.Mark = function()
  harpoonMark.add_file()
end

M.MarkJump = "Telescope harpoon marks"

M.MarkNext = function()
  -- TODO:
  vim.notify("TODO")
end
M.MarkPrev = function()
  -- TODO:
  vim.notify("TODO")
end

return M

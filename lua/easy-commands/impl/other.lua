local util = require("easy-commands.impl.util")
local editor = require("easy-commands.impl.util.editor")
local M = {}

M.QuitNvim = 'wqa!'

-- https://github.com/sindrets/diffview.nvim/issues/215#issuecomment-1250070954
M.DiffWithClipboard = {
  callback = function()
    local clipboard = vim.fn.getreg("*", 0, true) --[[@as string[] ]]
    local selected = vim.fn.split(editor.getSelectedText(), "\n")

    vim.cmd("tabnew")
    local selected_bufnr = vim.api.nvim_get_current_buf()
    local selectedName = vim.fn.tempname() .. "/selected"
    vim.api.nvim_buf_set_name(0, selectedName)
    vim.bo.buftype = "nofile"
    vim.api.nvim_buf_set_lines(selected_bufnr, 0, -1, false, selected)

    vim.cmd("enew")
    local clipboard_bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(0, vim.fn.tempname() .. "/clipboard")
    vim.bo.buftype = "nofile"
    vim.api.nvim_buf_set_lines(clipboard_bufnr, 0, -1, false, clipboard)

    vim.cmd("vertical diffsplit " .. vim.fn.fnameescape(selectedName))
    vim.cmd("wincmd p")
  end,
  allow_visual_mode = true
}

M.FormatCode = 'lua vim.lsp.buf.format { async = true }'
M.NoHighlight = 'nohl'

function M.CloseWindowOrBuffer()
  local isOk, _ = pcall(vim.cmd, "close")

  if not isOk then vim.cmd "bd" end
end

function M.CopyBufAbsPath()
  local buffer_path = vim.fn.expand('%:p')
  util.CopyToSystemClipboard(buffer_path)
end

function M.CopyBufAbsDirPath()
  local buffer_dir_path = vim.fn.expand('%:p:h')
  util.CopyToSystemClipboard(buffer_dir_path)
end

---@return string
function M.CopyProjectDir()
  util.CopyToSystemClipboard(util.FindProjectPath())
end

function M.CopyBufRelativePath()
  local buf_path = vim.fn.expand("%:p")
  local project_path = util.FindProjectPath() or ""
  local r = string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
  util.CopyToSystemClipboard(r)
end

function M.CopyBufRelativeDirPath()
  local buf_path = vim.fn.expand("%:p:h")
  local project_path = util.FindProjectPath() or ""
  local r = string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
  util.CopyToSystemClipboard(r)
end

return M

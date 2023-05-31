local util = require("easy-commands.impl.util")
local M = {}

M.QuitNvim = 'qa!'
-- M.DiffWithClipboard",
M.FormatCode = 'lua vim.lsp.buf.format { async = true }'
M.NoHighlight = 'nohl'
M.ToggleOutline = 'AerialToggle'

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

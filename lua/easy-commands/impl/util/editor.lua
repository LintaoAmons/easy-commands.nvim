---@class Editor
---@field selections Selections
local M = {
  selections = {},
}

---@alias Position {row: number, col: number}

---@class Selections
---@field getCursorPosition fun(): Position
---@field getVisualSelectionStartPosition fun(): Position
---@field getVisualSelectionEndPosition fun(): Position
local Selections = {}
-- =====================================================

M.selections = Selections

Selections.getCursorPosition = function()
  local _, row, col, _ = unpack(vim.fn.getpos("."))
  return { row, col }
end

---@return {row: number, col: number}
Selections.getVisualSelectionStartPosition = function()
  local _, row, col, _ = unpack(vim.fn.getpos("'<"))
  return { row, col }
end

---@return {row: number, col: number}
Selections.getVisualSelectionEndPosition = function()
  local _, row, col, _ = unpack(vim.fn.getpos("'>"))
  return { row, col }
end

local tableUtil = require("easy-commands.impl.util.base.table")

M.getCurrentLine = function()
  return vim.api.nvim_get_current_line()
end

M.getFiletype = function()
  return vim.bo.ft
end

--- Get current buffer size
---@return {width: number, height: number}
function M.get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

function M.get_buf_filename()
  return vim.fn.expand("%:t")
end

function M.get_buf_abs_path()
  return vim.fn.expand("%:p")
end

---@return string
function M.get_buf_abs_dir_path()
  return vim.fn.expand("%:p:h")
end

function M.get_buf_relative_path()
  local buf_path = M.get_buf_abs_path()
  local project_path = M.find_project_path() or ""
  return string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
end

function M.get_buf_relative_dir_path()
  local buf_path = M.get_buf_abs_path()
  local project_path = M.find_project_path() or ""
  return string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
end

local function is_homedir(path)
  local home_dir = vim.loop.os_homedir()
  return path == home_dir
end

local function contains_marker_file(path)
  local marker_files = { ".git", ".gitignore" } -- list of marker files
  for _, file in ipairs(marker_files) do
    local full_path = path .. "/" .. file
    if vim.fn.filereadable(full_path) == 1 or vim.fn.isdirectory(full_path) == 1 then
      return true
    end
  end
  return false
end

---@return string|nil
function M.find_project_path()
  for i = 1, 30, 1 do
    local dir = vim.fn.expand("%:p" .. string.rep(":h", i))
    if contains_marker_file(dir) then
      return dir
    end
    if is_homedir(dir) then
      return print("didn't found project_path")
    end
  end
  return print("excide the max depth")
end

function M.ExitCurrentMode()
  local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
end

-- Puts text at cursor, in any mode.
--
-- Compare |:put| and |p| which are always linewise.
--
-- Attributes: ~
--     not allowed when |textlock| is active
--
-- Parameters: ~
--   • {lines}   |readfile()|-style list of lines. |channel-lines|
--   • {type}    Edit behavior: any |getregtype()| result, or:
--               • "b" |blockwise-visual| mode (may include width, e.g. "b3")
--               • "c" |charwise| mode
--               • "l" |linewise| mode
--               • "" guess by contents, see |setreg()|
--   • {after}   If true insert after cursor (like |p|), or before (like
--               |P|).
--   • {follow}  If true place cursor at end of inserted text.
--- @param lines string[]
--- @param type string
--- @param after boolean
--- @param follow boolean
function M.putLines(lines, type, after, follow)
  vim.api.nvim_put(lines, type, after, follow)
end

-- Copy from https://github.com/ibhagwan/fzf-lua
function M.getSelectedText()
  -- this will exit visual mode
  -- use 'gv' to reselect the text
  local _, csrow, cscol, cerow, cecol
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "" then
    -- if we are in visual mode use the live position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
    if mode == "V" then
      -- visual line doesn't provide columns
      cscol, cecol = 0, 999
    end
    M.ExitCurrentMode()
  else
    -- otherwise, use the last known visual position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  end
  -- swap vars if needed
  if cerow < csrow then
    csrow, cerow = cerow, csrow
  end
  if cecol < cscol then
    cscol, cecol = cecol, cscol
  end
  local lines = vim.fn.getline(csrow, cerow)
  local n = tableUtil.table_length(lines)
  if n <= 0 then
    return ""
  end
  lines[n] = string.sub(lines[n], 1, cecol)
  lines[1] = string.sub(lines[1], cscol)
  return table.concat(lines, "\n")
end

function M.replaceSelectedTextWithClipboard()
  vim.cmd([[normal! gv"_dP]])
end

--- Create a new horizontal splitted buffer
--- and write the content into the buffer
---@param content string[]
---@param opts {vertical: boolean}
function M.splitAndWrite(content, opts)
  if opts.vertical then
    vim.cmd("vnew")
  else
    vim.cmd("new")
  end

  -- Get the current buffer
  local buf = vim.api.nvim_get_current_buf()

  -- Clear the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  -- Write the content into the buffer
  M.putLines(content, "", true, true)

  -- Set the buffer as unmodified
  vim.cmd("setlocal nomodified")
end

return M

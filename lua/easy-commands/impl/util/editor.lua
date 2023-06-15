-- Meta class
local Editor = {}
local tableUtil = require("easy-commands.impl.util.layer1.table")

Editor.getCurrentLine = function()
  return vim.api.nvim_get_current_line()
end

Editor.getFiletype = function()
  return vim.bo.ft
end

-- Copy from https://github.com/ibhagwan/fzf-lua
function Editor.getSelectedText()
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
    Editor.ExitCurrentMode()
  else
    -- otherwise, use the last known visual position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  end
  -- swap vars if needed
  if cerow < csrow then csrow, cerow = cerow, csrow end
  if cecol < cscol then cscol, cecol = cecol, cscol end
  local lines = vim.fn.getline(csrow, cerow)
  local n = tableUtil.tableLength(lines)
  if n <= 0 then return "" end
  lines[n] = string.sub(lines[n], 1, cecol)
  lines[1] = string.sub(lines[1], cscol)
  return table.concat(lines, "\n")
end

function Editor.ExitCurrentMode()
  local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'x', false)
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
function Editor.PutLines(lines, type, after, follow)
  vim.api.nvim_put(lines, type, after, follow)
end

function Editor.replaceSelectedTextWithClipboard()
  vim.cmd([[normal! gv"_dP]])
end

return Editor

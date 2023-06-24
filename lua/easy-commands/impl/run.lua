local M = {}
local util = require("easy-commands.impl.util")
local editor = require("easy-commands.impl.util.editor")
local strings= require("easy-commands.impl.util.base.strings")

M.RunCurrentBuffer = '%SnipRun'
M.RunLiveToggle = 'SnipLive'

M.RunCurrentLineAndOutput = function()
  local currentLine = vim.api.nvim_get_current_line()
  local output = util.Call_sys_cmd(currentLine)
  util.CopyToSystemClipboard("\n" .. output)
  vim.cmd("silent! normal! $p")
end

M.RunCurrentLineAndOutputWithPrePostFix = function()
  local currentLine = vim.api.nvim_get_current_line()
  local config = require("easy-commands.config").getConfig()
  local prefix = config.RunCurrentLineAndOutputWithPrePostFix.prefix
  local postfix = config.RunCurrentLineAndOutputWithPrePostFix.postfix
  local output = util.Call_sys_cmd(currentLine)
  util.CopyToSystemClipboard("\n" .. prefix .. "\n" .. strings.trim(output) .. "\n" .. postfix)
  vim.cmd("silent! normal! $p")
end

M.RunSelectedAndOutput = {
  callback = function()
    local selectedText = editor.getSelectedText()
    print(selectedText)
    local output = util.Call_sys_cmd(selectedText)
    util.CopyToSystemClipboard("\n" .. output)
    util.ExitCurrentMode()
    vim.cmd("silent! normal! $p")
  end,
  allow_visual_mode = true
}

M.RunSelectedAndReplace = {
  callback = function()
    local selectedText = editor.getSelectedText()
    local output = util.Call_sys_cmd(selectedText)
    util.CopyToSystemClipboard(strings.trim(output))
    editor.replaceSelectedTextWithClipboard()
  end,
  allow_visual_mode = true
}

M.RunSelectedAndOutputWithPrePostFix = {
  callback = function()
    local selectedText = editor.getSelectedText()
    local output = util.Call_sys_cmd(selectedText)
    local config = require("easy-commands.config").getConfig()
    local prefix = config.RunSelectedAndOutputWithPrePostFix.prefix
    local postfix = config.RunSelectedAndOutputWithPrePostFix.postfix
    util.CopyToSystemClipboard("\n" .. prefix .. "\n" .. strings.trim(output) .. "\n" .. postfix)
    util.ExitCurrentMode()
    vim.cmd("silent! normal! $p")
  end,
  allow_visual_mode = true
}

-- TODO: refactor those function into utils
function GetFirstLine()
  local firstLine = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  return firstLine
end

function GetFilename()
  local firstline = GetFirstLine()

  local last = ""
  for match in firstline:gmatch("[^:]+") do
    last = match
  end
  local trimmedStr = last:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace

  return trimmedStr
end

M.RunCmd = function ()
    -- TODO:
    -- type: csvq
    -- key: value

    -- get metaInfo
    -- get currentLine
    -- get Type and do something base on type
        -- FUNC currentLine --> cmdToExec
    -- Get the output of cmd and put lins
end

M.QueryCsv = function()
  -- new: /Users/lintao/Downloads/(RESTRICTED)_REGISTR_1686819230426.csv
  -- old: filepath2
  -- ========
  -- TODO: support alias

  local filename = GetFilename()
  -- csvq 'select Index from `/private/tmp/xx.csv` limit 6'
  local sql = editor.getCurrentLine()
  local sql = util.ReplacePattern(sql, "from fj", "from `" .. filename .. "`")
  sql = util.ReplacePattern(sql, "from jf", "from `" .. filename .. "`")
  local cmd = "csvq '" .. sql .. "'"
  local result = util.Call_sys_cmd(cmd) or ""
  -- TODO: refactor this
  local output_lines = vim.split(result, "\n")
  for i = #output_lines, 1, -1 do
    if output_lines[i] == "" then
      table.remove(output_lines, i)
    end
  end
  editor.PutLines(output_lines, 'l', true, true)
end

return M

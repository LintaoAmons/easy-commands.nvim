local M = {}
local util = require("easy-commands.impl.util")
local editor = require("easy-commands.impl.util.editor")

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
  util.CopyToSystemClipboard("\n" .. prefix .. "\n" .. util.Trim(output) .. "\n" .. postfix)
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
    util.CopyToSystemClipboard(util.Trim(output))
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
    util.CopyToSystemClipboard("\n" .. prefix .. "\n" .. util.Trim(output) .. "\n" .. postfix)
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

M.QueryCsv = function()
  local filename = GetFilename()
  -- csvq 'select Index from `/private/tmp/xx.csv` limit 6'
  local sql = editor.getCurrentLine()
  local sql = util.ReplacePattern(sql, "from fj", "from `" .. filename .. "`")
  vim.print(sql)
  local cmd = "csvq '" .. sql .. "'"
  local result = util.Call_sys_cmd(cmd) or ""
  -- TODO: refactor this
  local output_lines = vim.split(result, "\n")
  for i = #output_lines, 1, -1 do
    if output_lines[i] == "" then
      table.remove(output_lines, i)
    end
  end
  -- table.insert(output_lines, 0, "```")
  -- table.insert(output_lines, "```")
  vim.print(output_lines)

  vim.api.nvim_put(output_lines, 'l', true, true)

  -- editor.PutLines(output_lines, 'l', true, true)
  -- editor.PutLines(output_lines, 'l', true, true)
end

return M

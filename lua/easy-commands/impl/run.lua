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
    local selectedText = editor.getSelectedText2()
    local output = util.Call_sys_cmd(selectedText)
    util.CopyToSystemClipboard("\n" .. output)
    util.ExitCurrentMode()
    vim.cmd("silent! normal! $p")
  end,
  allow_visual_mode = true
}

M.RunSelectedAndReplace = {
  callback = function()
    util.Perform_cmd_to_selected_text(function(it)
      return it
    end)
  end,
  allow_visual_mode = true
}

M.RunSelectedAndOutputWithPrePostFix = {
  callback = function()
    local selectedText = editor.getSelectedText2()
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

return M

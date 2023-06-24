local M = {}
local util = require("easy-commands.impl.util")
local config = require("easy-commands.config")
local editor = require("easy-commands.impl.util.editor")

M.AskChatGPT = function()
  local currentLine = util.ReplacePattern(vim.api.nvim_get_current_line(), "'", "")
  currentLine = util.ReplacePattern(currentLine, "-", "")
  local cmd = "toolbox askChatGPT '" .. currentLine .. "'"
  local output = util.Call_sys_cmd(cmd) or ""
  local output_lines = vim.split(output, "\n")
  for i = #output_lines, 1, -1 do
    if output_lines[i] == "" then
      table.remove(output_lines, i)
    end
  end
  editor.PutLines(output_lines, 'l', true, true)
end

M.AskChatGPTWithSelection = {
  callback = function()
    local key = vim.env.CHAT_GTP_KEY
    if not key then
      key = util.ReadFileAsString(config.getConfig().keyFilePath)
    end
    local content = util.ReplacePattern(util.Buf_vtext(), "'", "")
    local cmd = "toolbox chatGPT '" .. content .. "' " .. key
    -- vim.print(cmd)
    local output = util.Call_sys_cmd(cmd)
    util.CopyToSystemClipboard(output)
    -- TODO: Paste at the end of Selection
    vim.cmd("silent! normal! $p")
  end,

  allow_visual_mode = true,
}

return M

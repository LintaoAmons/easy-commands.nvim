local M = {}
local util = require("easy-commands.impl.util")
local config = require("easy-commands.config")

M.AskChatGPT = function()
  local key = vim.env.CHAT_GTP_KEY
  if not key then
    key = util.ReadFileAsString(config.getConfig().keyFilePath)
  end
  local currentLine = util.ReplacePattern(vim.api.nvim_get_current_line(), "'", "")
  local cmd = "toolbox chatGPT '" .. currentLine .. "' " .. key
  -- vim.print(cmd)
  local output = util.Call_sys_cmd(cmd)
  util.CopyToSystemClipboard(output)
  vim.cmd("silent! normal! $p")
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
    -- TODO: Async
    vim.cmd("silent! normal! $p")
  end,

  allow_visual_mode = true,
}

return M

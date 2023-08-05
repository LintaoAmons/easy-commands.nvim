---@type EasyCommand.Command[]
local M = {
  {
    name = "RunCurrentBuffer",
    callback = "%SnipRun",
    dependencies = { "https://github.com/michaelb/sniprun" },
  },
  {
    name = "RunLiveToggle",
    callback = "SnipLive",
    dependencies = { "https://github.com/michaelb/sniprun" },
  },
  {
    name = "RunShellCurrentLine",
    callback = function()
      local sys = require("easy-commands.impl.util.base.sys")
      local editor = require("easy-commands.impl.util.editor")
      local stringUtil = require("easy-commands.impl.util.base.strings")
      local currentLine = editor.getCurrentLine()
      local stdout, _, stderr = sys.run_os_cmd(stringUtil.splitCmdString(currentLine), ".")
      local result = stdout or stderr
      editor.putLines(result, "l", true, true)
      pcall(sys.CopyToSystemClipboard, stringUtil.join(result, "\n"))
    end,
    description = "Run current line as a cmd in bash and put the stdout in the following lines",
  },
  -- {
  -- 	name = "QueryCsv",
  -- 	callback = function()
  -- 		local filename = GetFilename()
  -- 		local sql = editor.getCurrentLine()
  -- 		sql = util.ReplacePattern(sql, "from fj", "from `" .. filename .. "`")
  -- 		sql = util.ReplacePattern(sql, "from jf", "from `" .. filename .. "`")
  -- 		local cmd = "csvq '" .. sql .. "'"
  -- 		local result = util.Call_sys_cmd(cmd) or ""
  -- 		local output_lines = vim.split(result, "\n")
  -- 		for i = #output_lines, 1, -1 do
  -- 			if output_lines[i] == "" then
  -- 				table.remove(output_lines, i)
  -- 			end
  -- 		end
  -- 		editor.PutLines(output_lines, "l", true, true)
  -- 	end,
  -- },
}

return M

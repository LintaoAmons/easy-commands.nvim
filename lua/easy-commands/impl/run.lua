-- TODO: refactor this function
local function write_to_temp_file(content)
  local tempfile = os.tmpname()
  local file = io.open(tempfile, "w")
  file:write(content)
  file:close()
  return tempfile
end

---@type EasyCommand.Command[]
local M = {
  {
    -- TODO: Trim selected; dot repeatable
    name = "TrimLine",
    callback = function()
      local line = vim.api.nvim_get_current_line()
      local trimmed = string.match(line, "^%s*(.-)%s*$")
      vim.api.nvim_set_current_line(trimmed)
    end,
  },
  {
    name = "DistinctLines",
    callback = "sort u",
  },
  {
    name = "Hurl",
    callback = function()
      local sys = require("easy-commands.impl.util.base.sys")
      local editor = require("easy-commands.impl.util.editor")
      local bufferAbsPath = editor.get_buf_abs_path()
      local stdout, _, stderr = sys.run_os_cmd({ "hurl", "--verbose", bufferAbsPath }, ".")
      local result = stdout or stderr
      editor.splitAndWrite(result, { vertical = true })
    end,
    description = "use `hurl` to run current buffer and output to splitted window",
  },
  {
    name = "HurlSelected",
    callback = function()
      local sys = require("easy-commands.impl.util.base.sys")
      local editor = require("easy-commands.impl.util.editor")
      local content = editor.getSelectedText()
      local tmpFile = write_to_temp_file(content)
      local stdout, _, stderr = sys.run_os_cmd({ "hurl", "--verbose", tmpFile }, ".")
      local result = stdout or stderr
      editor.splitAndWrite(result, { vertical = true })
    end,
    description = "use `hurl` to run current buffer and output to splitted window",
    dependencies = { "https://hurl.dev/" },
    allow_visual_mode = true,
  },
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
  {
    name = "JqQuery",
    callback = function()
      local sys = require("easy-commands.impl.util.base.sys")
      local editor = require("easy-commands.impl.util.editor")

      vim.ui.input({ prompt = 'Query pattern, e.g. `.[] | .["@message"].message`' }, function(pattern)
        local absPath = editor.get_buf_abs_path()
        local stdout, _, stderr = sys.run_os_cmd({ "jq", pattern, absPath }, ".")
        local result = stdout or stderr
        editor.splitAndWrite(result, { vertical = true })
      end)
    end,
    description = "use `jq` to query current json file",
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

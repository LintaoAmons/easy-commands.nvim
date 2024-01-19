-- TODO: refactor this function
local function write_to_temp_file(content)
  local tempfile = os.tmpname()
  local file = io.open(tempfile, "w")
  file:write(content)
  file:close()
  return tempfile
end

local function processCSV(lines)
  -- Determine the maximum width of each column
  local colWidths = {}
  for _, line in ipairs(lines) do
    local col = 1
    for value in line:gmatch("[^,]+") do
      colWidths[col] = math.max(colWidths[col] or 0, #value)
      col = col + 1
    end
  end

  -- Align the columns and rebuild the lines
  local prettified = {}
  for _, line in ipairs(lines) do
    local col = 1
    local newLine = {}
    for value in line:gmatch("[^,]+") do
      table.insert(newLine, value .. string.rep(" ", colWidths[col] - #value))
      col = col + 1
    end
    table.insert(prettified, table.concat(newLine, ", "))
  end

  return prettified
end

local function get_current_buffer_content(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  return lines
end

local function prettify_csv()
  local buf = vim.api.nvim_get_current_buf()
  local prettified = processCSV(get_current_buffer_content(buf))
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, prettified)
end

---@type EasyCommand.Command[]
local M = {
  {
    name = "CsvPrettify",
    callback = prettify_csv,
  },
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
      local bufferAbsPath = editor.buf.read.get_buf_abs_path()
      local stdout, _, stderr = sys.run_sync({ "hurl", "--verbose", bufferAbsPath }, ".")
      local result = stdout or stderr
      editor.split_and_write(result, { vertical = true })
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
      local stdout, _, stderr = sys.run_sync({ "hurl", "--verbose", tmpFile }, ".")
      local result = stdout or stderr
      editor.split_and_write(result, { vertical = true })
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
      local currentLine = editor.get_current_line()
      local stdout, _, stderr = sys.run_sync(stringUtil.splitCmdString(currentLine), ".")
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

      vim.ui.input(
        { prompt = 'Query pattern, e.g. `.[] | .["@message"].message`' },
        function(pattern)
          local absPath = editor.buf.read.get_buf_abs_path()
          local stdout, _, stderr = sys.run_sync({ "jq", pattern, absPath }, ".")
          local result = stdout or stderr
          editor.split_and_write(result, { vertical = true })
        end
      )
    end,
    description = "use `jq` to query current json file",
  },
  {
    name = "SendSelectedToTerminalAndRun",
    allow_visual_mode = true,
    callback = function()
      require("easy-commands.impl.run.run").send_selected_to_terminal_and_run()
    end,
  },
  {
    name = "SendLineToTerminalAndRun",
    allow_visual_mode = true,
    callback = function()
      require("easy-commands.impl.run.run").send_line_to_terminal_and_run()
    end,
  },
  {
    name = "SendToTerminalAndRun",
    allow_visual_mode = true,
    callback = function()
      require("easy-commands.impl.run.run").sent_to_terminal_and_run()
    end,
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

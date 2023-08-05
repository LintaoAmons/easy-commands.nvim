local M = {}

function M.ReplacePattern(str, pattern, replacement)
  return string.gsub(str, pattern, replacement)
end

M.trim = function(input)
  return input:gsub("^%s*(.-)%s*$", "%1")
end

M.contains = function(str, char)
  for i = 1, #str do
    if str:sub(i, i) == char then
      return true
    end
  end
  return false
end

function M.EndsWithSuffix(str, suffix)
  local len = #suffix
  return str:sub(-len) == suffix
end

---@param i string
---@return string[]
function M.splitIntoLines(i)
  local lines = {}
  for line in i:gmatch("([^\n]*)\n?") do
    if line ~= "" then
      table.insert(lines, line)
    end
  end
  return lines
end

---@param stringList string[]
---@param delimiter string
---@return string
function M.join(stringList, delimiter)
    local str = ''
    for i, s in ipairs(stringList) do
        str = str .. s
        if i ~= #stringList then
            str = str .. delimiter
        end
    end
    return str
end

---@param cmd string
---@return string[]
function M.splitCmdString(cmd)
    local t = {}
    local inQuotes = false
    local currentQuoteChar = nil
    local currentWord = ""

    for i = 1, #cmd do
        local c = cmd:sub(i,i)
        if c == " " and not inQuotes then
            if #currentWord > 0 then
                table.insert(t, currentWord)
                currentWord = ""
            end
        elseif c == "'" or c == '"' then
            if inQuotes and currentQuoteChar == c then
                inQuotes = false
                currentQuoteChar = nil
            elseif not inQuotes then
                inQuotes = true
                currentQuoteChar = c
            else
                currentWord = currentWord .. c
            end
        else
            currentWord = currentWord .. c
        end
    end
    if #currentWord > 0 then
        table.insert(t, currentWord)
    end
    return t
end

return M

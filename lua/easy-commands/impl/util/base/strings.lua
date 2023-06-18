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

return M

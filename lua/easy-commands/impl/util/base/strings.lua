local M = {}

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

return M

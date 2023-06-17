local M = {}

M.Trim = function(input)
    return input:gsub("^%s*(.-)%s*$", "%1")
end

return M

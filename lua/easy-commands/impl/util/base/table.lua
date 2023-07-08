local M        = {}

M.table_length = function(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function M.findIndex(tbl, element)
  for i = 1, #tbl do
    if tbl[i] == element then
      return i
    end
  end
  return nil
end

---@param element any
---@param table any
---@return boolean
function M.isElementInTable(element, table)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

return M

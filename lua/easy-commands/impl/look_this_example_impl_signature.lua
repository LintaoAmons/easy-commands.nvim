local M = {}

---@return table
-- The result table has the following structure:
--   {
--     callback = string|function,
--     dependency = string
--     allow_visual_mode = bool?,
--   }
--
function M.ImplExample1()
  return {
    callback = "<CMD>echo haha<CR>",
    allow_visual_mode = true,
  }
end

function M.ImplExample2()
  return {
    callback = function()
      vim.cmd("echo haha")
    end,
  }
end

return M

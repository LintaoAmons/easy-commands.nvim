local M = {}

M.SourceCurrentBuffer = function ()
  vim.cmd("source %")
end

return M

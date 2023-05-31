local M = {}
local util = require("easy-commands.impl.util")

M.TestRunNearest = 'lua require("neotest").run.run()'
M.TestRunCurrentFile = 'lua require("neotest").run.run(vim.fn.expand("%"))'
M.TestRunLast = 'lua require("neotest").run.run_last()'
M.TestToggleOutputPanel = 'lua require("neotest").output_panel.toggle()'
M.TestDebugNearest = 'lua require("dap-go").debug_test()'
M.GoToTestFile = function()
  local ok, _ = pcall(require("easy-commands.impl.lang." .. util.getFiletype()).GoToTestFile)
  if not ok then
    vim.notify("Maybe not implemented yet for " .. util.getFiletype())
  end
end

return M

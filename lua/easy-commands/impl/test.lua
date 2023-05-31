local M = {}
M.TestRunNearest = 'lua require("neotest").run.run()'
M.TestRunCurrentFile = 'lua require("neotest").run.run(vim.fn.expand("%"))'
M.TestRunLast = 'lua require("neotest").run.run_last()'
M.TestToggleOutputPanel = 'lua require("neotest").output_panel.toggle()'
M.TestDebugNearest = 'lua require("dap-go").debug_test()'
-- M.GoToTestFile",

return M

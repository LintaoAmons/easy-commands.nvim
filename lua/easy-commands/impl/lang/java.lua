local M = {}

M.GoToTestFile = function()
  require("jdtls.tests").goto_subjects()
end

M.DebugTest = function()
  require("jdtls").test_class()
end

return M

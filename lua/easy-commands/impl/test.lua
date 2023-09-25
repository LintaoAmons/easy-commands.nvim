local langUtil = require("easy-commands.impl.util.lang")
---@type EasyCommand.Command[]
local M = {
	{
		name = "TestRunNearest",
		callback = 'lua require("neotest").run.run()',
		dependencies = { "https://github.com/nvim-neotest/neotest" },
	},

	{
		name = "TestRunCurrentFile",
		callback = 'lua require("neotest").run.run(vim.fn.expand("%"))',
		dependencies = { "https://github.com/nvim-neotest/neotest" },
	},

	{
		name = "TestRunLast",
		callback = 'lua require("neotest").run.run_last()',
		dependencies = { "https://github.com/nvim-neotest/neotest" },
	},

	{
		name = "TestToggleOutputPanel",
		callback = 'lua require("neotest").output_panel.toggle()',
		dependencies = { "https://github.com/nvim-neotest/neotest" },
	},

	-- {
	-- 	name = "TestDebugNearest",
	-- 	callback = 'lua require("dap-go").debug_test()',
	-- },
	--
	{
		name = "GoToTestFile",
		callback = function()
			langUtil.CallLanguageSpecificFunc("GoToTestFile")
		end,
	},
	{
		name = "TestPlugin",
		callback = function()
			local col, row = unpack(require("easy-commands.impl.util.editor").selections.getCursorPosition())
			print(col, row)
		end,
	},
}

return M

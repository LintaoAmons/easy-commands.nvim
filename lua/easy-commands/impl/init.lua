local M = {}

M = vim.tbl_extend(
	"error",
	M,
	require("easy-commands.impl.editor"),
	require("easy-commands.impl.other"),
	require("easy-commands.impl.refactor"),
	require("easy-commands.impl.navigation"),
	require("easy-commands.impl.finder"),
	require("easy-commands.impl.git"),
	require("easy-commands.impl.run"),
	require("easy-commands.impl.test"),
	require("easy-commands.impl.explorer"),
	require("easy-commands.impl.ai"),
	require("easy-commands.impl.helper"),
	require("easy-commands.impl.nvim")
)

return M

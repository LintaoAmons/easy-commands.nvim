---@param cmdsList EasyCommand.Command[][]
---@return EasyCommand.Command[]
local function combineCmds(cmdsList)
	local m = {}
	for _, cmds in ipairs(cmdsList) do
		for _, c in ipairs(cmds) do
			table.insert(m, c)
		end
	end
	return m
end

return combineCmds({
	require("easy-commands.impl.ai"),
	require("easy-commands.impl.explorer"),
	require("easy-commands.impl.run"),
	require("easy-commands.impl.test"),
	require("easy-commands.impl.test"),
	require("easy-commands.impl.helper"),
	require("easy-commands.impl.nvim"),
	require("easy-commands.impl.refactor"),
	require("easy-commands.impl.editor"),
	require("easy-commands.impl.git"),
	require("easy-commands.impl.navigation"),
	require("easy-commands.impl.finder"),
	require("easy-commands.impl.other"),
  require("easy-commands.impl.debug")
})

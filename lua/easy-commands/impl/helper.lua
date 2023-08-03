---@type EasyCommand.Command[]
local M = {
	{
		name = "PrintSelected",
		callback = function()
			local lang = require("easy-commands.impl.util.lang")
			lang.CallLanguageSpecificFunc("PrintSelected")
		end,
	},
}

return M

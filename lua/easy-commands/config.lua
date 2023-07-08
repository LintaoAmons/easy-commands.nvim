local default_config = {
	disabledCommands = {},
	["RunCurrentLineAndOutputWithPrePostFix"] = {
		prefix = "```bash",
		postfix = "```",
	},
	["RunSelectedAndOutputWithPrePostFix"] = {
		prefix = "```bash",
		postfix = "```",
	},
	["AskChatGPT"] = {
		keyFilePath = vim.env.HOME .. "/chatGPTkey",
	},
	myCommands = { ["EasyCommand"] = 'lua vim.print("easy command user command")' },
}

local Config = {}
Config.config = default_config

---@param implementation nil | string | function | table  -- The implementation of the user command.
---@param commandName string  -- The name of the user command to be registered.
local function registerUserCommand(implementation, commandName)
	if not implementation then
		vim.api.nvim_create_user_command(commandName, "lua = vim.notify('No implementation yet')", {})
		return
	end

	if type(implementation) == "function" or type(implementation) == "string" then
		vim.api.nvim_create_user_command(commandName, implementation, {})
		return
	end

	if type(implementation) == "table" then
		if implementation.allow_visual_mode then
			-- https://github.com/ray-x/go.nvim/blob/711b3b84cf59d3c43a9d1b02fdf12152b397e7b1/lua/go/commands.lua#LL443C7-L443C20
			vim.api.nvim_create_user_command(commandName, implementation.callback, { range = true })
			return
		end
	end
end

Config.setup = function(user_config)
	Config.config = vim.tbl_deep_extend("force", default_config, user_config)

	local commands_name = require("easy-commands.names")
	local inuse_commands = require("easy-commands.impl.util.base.table").getDifferenceSet(
		commands_name,
		Config.getConfig().disabledCommands
	)

	local impl = require("easy-commands.impl")
	for _, command in pairs(inuse_commands) do
		local implementation = impl[command]
		registerUserCommand(implementation, command)
	end

	for name, commandImpl in pairs(Config.getConfig().myCommands) do
		registerUserCommand(commandImpl, name)
	end
end

Config.getConfig = function()
	return Config.config
end

return Config

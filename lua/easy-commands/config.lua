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
	---@type EasyCommand.Command[]
	myCommands = { {
		name = "EasyCommand",
		callback = 'lua vim.print("easy command user command")',
	} },
}

local Config = {}
Config.config = default_config

---@param msg string
local function notifyErr(msg)
	vim.notify("easy-comands: \n" .. msg, vim.log.levels.ERROR, { title = "easy-commands.nvim" })
end

---@param cmd EasyCommand.Command
---@return string
local function formErrorMsg(cmd)
	local msg = "Something went wrong when calling [" .. cmd.name .. "]\n"
	if cmd.dependencies then
		msg = msg .. "Please check dependencies firstly" .. "\n"
		for _, d in ipairs(cmd.dependencies) do
			msg = msg .. "    - " .. d .. "\n"
		end
	end
  msg = msg .. "Run: InspectCommand <CommandName> to find the path of implemented and investgate more"
	if cmd.errorInfo then
		msg = msg + "Here more info you can check: \n" .. "    " .. "cmd.errorInfo"
	end
	return msg
end

---@param cmd EasyCommand.Command
local function safeCallWithErrMsg(cmd)
	return function()
		local ok
		local callback = cmd.callback
		if type(callback) == "string" then
			---@cast callback string
			ok, _ = pcall(function()
				vim.cmd(callback)
			end)
		else
			---@cast callback fun():nil
			ok, _ = pcall(callback)
		end

		if not ok then
			notifyErr(formErrorMsg(cmd))
		end
	end
end

---@param implementation? EasyCommand.Command  -- The implementation of the user command.
---@param commandName string  -- The name of the user command to be registered.
local function registerUserCommand(implementation, commandName)
	if not implementation then
		vim.api.nvim_create_user_command(commandName, function()
			notifyErr(commandName .. " not implemented yet")
		end, {})
		return
	end

	if not require("easy-commands._types").isCommand(implementation) then
		vim.api.nvim_create_user_command(commandName, function()
			notifyErr(commandName .. " not properly implemented")
		end, {})
		return
	end

	---@cast implementation EasyCommand.Command
	-- TODO: check dependencies and show alart or show dependency when user call command failed
	if implementation.allow_visual_mode then
		-- https://github.com/ray-x/go.nvim/blob/711b3b84cf59d3c43a9d1b02fdf12152b397e7b1/lua/go/commands.lua#LL443C7-L443C20
		vim.api.nvim_create_user_command(
			commandName,
			safeCallWithErrMsg(implementation),
			{ range = true, desc = implementation.description }
		)
		return
	end

	vim.api.nvim_create_user_command(
		commandName,
		safeCallWithErrMsg(implementation),
		{ desc = implementation.description }
	)
end

local function registerUserCustomCommand()
	for _, c in pairs(Config.getConfig().myCommands) do
		registerUserCommand(c, c.name)
	end
end

---@return {[string]: EasyCommand.Command}
local function buildCommandMap()
	---@type EasyCommand.Command[]
	local commands = require("easy-commands.impl")
	local map = {}
	for _, c in ipairs(commands) do
		map[c.name] = c
	end
	return map
end

local function registerUserCommands(commandNames)
	local commandsMap = buildCommandMap()
	for _, command in pairs(commandNames) do
		local implementation = commandsMap[command]
		registerUserCommand(implementation, command)
	end
end

---@param user_config? table
Config.setup = function(user_config)
	Config.config = vim.tbl_deep_extend("force", default_config, user_config or {})

	local commands_name = require("easy-commands.names")
	local inuse_commands = require("easy-commands.impl.util.base.table").getDifferenceSet(
		commands_name,
		Config.getConfig().disabledCommands
	)

	-- registerUserCommands(inuse_commands)
	registerUserCommands(inuse_commands)

	registerUserCustomCommand()
end

Config.getConfig = function()
	return Config.config
end

return Config

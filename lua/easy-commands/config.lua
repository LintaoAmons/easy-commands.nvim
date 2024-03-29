local default_config = {
  disabledCommands = {},
  ---@type EasyCommand.Command[]
  myCommands = {
    {
      name = "EasyCommand",
      callback = 'lua vim.print("easy command user command")',
    },
  },
  aliases = {
    {
      from = "GitAddHunk",
      to = "GitStageHunk",
    },
  },
}

local Config = {}
Config.config = default_config

---@param msg string
local function notifyErr(msg)
  vim.notify("easy-comands.nvim: \n" .. msg, vim.log.levels.ERROR, { title = "easy-commands.nvim" })
end

---@param cmd EasyCommand.Command
---@param err any | nil
---@return string
local function formErrorMsg(cmd, err)
  local msg = "Something went wrong when calling [" .. cmd.name .. "]\n"
  if cmd.dependencies then
    msg = msg .. "\nPlease check dependencies firstly(required by this command)" .. "\n"
    for _, d in ipairs(cmd.dependencies) do
      msg = msg .. "    - " .. d .. "\n"
    end
  end
  msg = msg .. "\nRun `:InspectCommand " .. cmd.name .. "` to investgate the implementation \n"
  msg = msg .. "Or raise a issue in https://github.com/LintaoAmons/easy-commands.nvim/issues\n"
  msg = msg .. "\nError: \n" .. err

  if cmd.errorInfo then
    msg = msg + "Here more info you can check: \n" .. "    " .. cmd.errorInfo
  end
  msg = string.gsub(msg, "^I", "  ")
  return msg
end

---@param cmd EasyCommand.Command
local function safeCallWithErrMsg(cmd)
  return function()
    local ok
    local err
    local callback = cmd.callback
    if type(callback) == "string" then
      ---@cast callback string
      ok, err = pcall(function()
        vim.cmd(callback)
      end)
    else
      ---@cast callback fun():nil
      ok, err = pcall(callback)
    end

    if not ok then
      notifyErr(formErrorMsg(cmd, err))
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
      -- TODO: default range to true
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

---@param aliases {from: "string", to: "string"}[]
local function registerAliases(aliases)
  for _, alias in ipairs(aliases) do
    vim.api.nvim_create_user_command(alias.to, alias.from, {})
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

  registerUserCommands(inuse_commands)

  registerUserCustomCommand()

  registerAliases(Config.config.aliases)
end

Config.getConfig = function()
  return Config.config
end

return Config

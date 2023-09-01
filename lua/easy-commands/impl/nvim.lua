---@type EasyCommand.Command[]
local M = {
	{
		name = "SourceCurrentBuffer",
		callback = "source %",
	},
  {
    name = "CheckKeymapDefinitions",
    callback = "verbose map",
    description = "Show all the keymaps and show the location of definition\n"
    .. "Can help you to debug keymap configuration"
  }
}

return M

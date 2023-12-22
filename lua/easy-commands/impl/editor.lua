---@type EasyCommand.Command[]
local M = {
	{
		name = "ShowLineDiagnostics",
		callback = "Lspsaga show_line_diagnostics",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
		description = "Show diagnoestics of current line",
	},
	{
		name = "Wrap",
		callback = "set wrap",
	},

	{
		name = "UnWrap",
		callback = "set unwrap",
	},
	{
		name = "CodeActions",
		callback = "Lspsaga code_action",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
		description = "Show available code actions",
	},
	{
		name = "ToggleAutoSave",
		callback = function()
			local function save()
				local buf = vim.api.nvim_get_current_buf()

				vim.api.nvim_buf_call(buf, function()
					vim.cmd("silent! write")
				end)
			end

			local flag = vim.g.easy_command_auto_save or false
			if flag then
				vim.api.nvim_del_augroup_by_name("AutoSave")
				vim.g.easy_command_auto_save = false
				vim.print("AutoSave disabled")
			else
				vim.api.nvim_create_augroup("AutoSave", {
					clear = true,
				})
				vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
					callback = function()
						save()
					end,
					pattern = "*",
					group = "AutoSave",
				})
				vim.g.easy_command_auto_save = true
				vim.print("AutoSave enabled")
			end
		end,
	},
}

return M

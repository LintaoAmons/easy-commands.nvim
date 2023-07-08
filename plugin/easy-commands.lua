if vim.fn.has("nvim-0.7.0") == 0 then
	vim.api.nvim_err_writeln("scratch requires at least nvim-0.7.0.1")
	return
end

-- make sure this file is loaded only once
if vim.g.loaded_easy_commands == 1 then
	return
end
vim.g.loaded_easy_commands = 1


local function call_command_with_fail_hints(cmd)
	local isOk, _ = pcall(vim.cmd, "Lspsaga rename")
	if not isOk then
		vim.notify(
			"Failed to call command `Rename`\nCheck dependency `Lspsaga`",
			vim.log.levels.ERROR,
			{ title = "easy-commands.nvim" }
		)
	end
end


local M = {}

M.ToggleLf = function()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lf",
		hidden = true,
		direction = "float",
		float_opts = {
			border = "none",
			width = 100000,
			height = 100000,
		},
		on_open = function(_)
			vim.cmd("startinsert!")
		end,
		on_close = function(_) end,
		count = 99,
	})
	lazygit:toggle()
end

M.SwitchProject = "Telescope projects"
M.OpenChangedFiles = "Telescope git_status"
M.OpenRecentFiles = "lua require('telescope').extensions.recent_files.pick()"
M.OpenRecentFilesInAllPlaces = "lua require('telescope').extensions.recent_files.pick({only_cwd = false})"

M.ToggleOutline = "Lspsaga outline"
M.LspFinder = "Lspsaga finder"
M.GoToDefinition = "Lspsaga goto_type_definition"

M.Flash = function()
	require("flash").jump()
end

M.FlashTreesitter = function()
	require("flash").treesitter()
end

M.MaximiseBuffer = function()
	-- Get the current buffer number
	local current_bufnr = vim.api.nvim_get_current_buf()

	-- Create a new tab and switch to it
	vim.api.nvim_command("tabnew")

	-- Get the new tab's buffer number
	local new_bufnr = vim.api.nvim_get_current_buf()

	-- Copy the contents of the current buffer to the new buffer
	vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, vim.api.nvim_buf_get_lines(current_bufnr, 0, -1, false))

	-- Set the file type of the new buffer to match the current buffer
	vim.api.nvim_buf_set_option(new_bufnr, "filetype", vim.api.nvim_buf_get_option(current_bufnr, "filetype"))

	-- Set the modified flag of the new buffer to match the current buffer
	vim.api.nvim_buf_set_option(new_bufnr, "modified", vim.api.nvim_buf_get_option(current_bufnr, "modified"))

	-- Switch back to the original buffer in the new tab
	vim.api.nvim_set_current_buf(current_bufnr)
end

M.TabNext = "tabnext"
M.TabPrev = "tabprevious"
M.TabClose = "tabclose"
M.TabNew = "tabnew"

M.BufferNext = "BufferLineCycleNext"

M.BufferPrev = "BufferLineCyclePrev"

M.SplitVertically = "vsplit"

M.MaximiseBufferAndCloseOthers = function()
	-- TODO:
	vim.notify("TODO")
end

M.IncreaseSplitWidth = "vertical resize +5"

M.DecreaseSplitWidth = "vertical resize -5"

M.Mark = function()
	require("harpoon.mark").add_file()
end

M.MarkList = "Telescope harpoon marks"

M.MarkNext = function()
	-- TODO:
	vim.notify("TODO")
end
M.MarkPrev = function()
	-- TODO:
	vim.notify("TODO")
end

M.FoldAll = "lua require('ufo').closeAllFolds()"

M.UnFoldAll = "lua require('ufo').openAllFolds()"

M.PeekDefinition = "Lspsaga peek_definition"
M.PeekTypeDefinition = "Lspsaga peek_type_definition"
M.PeekGitChange = "Gitsigns preview_hunk"

return M

local function goToDefinitionInSplit()
	local buffer = require("easy-commands.impl.util.editor").window
	buffer.maximiseWindow()
	buffer.splitWindow("virtical")
	vim.api.nvim_command("Lspsaga goto_definition")
	-- vim.api.nvim_command("zz") TODO: how to write "zz" by lua function
end

---@type EasyCommand.Command[]
local M = {
	-- {
	-- 	name = "SwitchProject",
	-- 	callback = "Telescope projects",
	-- 	dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	-- },
	{
		name = "GoToDefinitionInSplit",
		callback = goToDefinitionInSplit,
		description = "enhances code navigation and exploration in Neovim by focusing on a specific symbol and opening its definition in a right split.",
	},
	{
		name = "GoToDefinitionSmart",
		callback = function()
			local windowCount = require("easy-commands.impl.util.editor").tab.countWindows()

			if windowCount == 1 then
				vim.api.nvim_command("GoToDefinition")
			else
				goToDefinitionInSplit()
			end
		end,
		description = "Switch the GoToDefinition commands' behaviour (in current buf | in split)",
	},

	{
		name = "OpenChangedFiles",
		callback = "Telescope git_status",
		dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
	},

	{
		name = "OpenRecentFiles",
		callback = "lua require('telescope').extensions.recent_files.pick()",
		dependencies = {
			"https://github.com/nvim-telescope/telescope.nvim",
			"https://github.com/smartpde/telescope-recent-files",
		},
	},

	{
		name = "OpenRecentFilesInAllPlaces",
		callback = "lua require('telescope').extensions.recent_files.pick({only_cwd = false})",
		dependencies = {
			"https://github.com/nvim-telescope/telescope.nvim",
			"https://github.com/smartpde/telescope-recent-files",
		},
	},

	{
		name = "ToggleOutline",
		callback = "Lspsaga outline",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
	},

	{
		name = "LspFinder",
		callback = "Lspsaga finder",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
	},

	{
		name = "GoToDefinition",
		callback = "Lspsaga goto_definition",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
	},

	{
		name = "MaximiseBuffer",
		callback = function()
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
		end,
		description = "maxise current buffer by open it in a new tab",
	},

	{
		name = "TabNext",
		callback = "tabnext",
	},

	{
		name = "TabPrev",
		callback = "tabprevious",
	},

	{
		name = "TabClose",
		callback = "tabclose",
	},

	{
		name = "TabNew",
		callback = "tabnew",
	},

	{
		name = "BufferNext",
		callback = "BufferLineCycleNext",
		dependencies = { "https://github.com/akinsho/bufferline.nvim" },
	},

	{
		name = "BufferPrev",
		callback = "BufferLineCyclePrev",
		dependencies = { "https://github.com/akinsho/bufferline.nvim" },
	},

	{
		name = "SplitVertically",
		callback = "vsplit",
	},
	{
		name = "Split",
		callback = "split",
	},

	-- {
	-- 	name = "MaximiseBufferAndCloseOthers",
	-- 	callback = function()
	-- 		-- TODO:
	-- 		vim.notify("TODO")
	-- 	end,
	-- },

	{
		name = "IncreaseSplitWidth",
		callback = "vertical resize +5",
	},

	{
		name = "DecreaseSplitWidth",
		callback = "vertical resize -5",
	},

	{
		name = "FoldAll",
		callback = "lua require('ufo').closeAllFolds()",
		dependencies = { "https://github.com/kevinhwang91/nvim-ufo" },
	},

	{
		name = "UnFoldAll",
		callback = "lua require('ufo').openAllFolds()",
		dependencies = { "https://github.com/kevinhwang91/nvim-ufo" },
	},

	{
		name = "PeekDefinition",
		callback = "Lspsaga peek_definition",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
	},

	{
		name = "PeekTypeDefinition",
		callback = "Lspsaga peek_type_definition",
		dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
	},

	{
		name = "PeekGitChange",
		callback = "Gitsigns preview_hunk",
		dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
	},
}

return M

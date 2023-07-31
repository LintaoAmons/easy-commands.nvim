local util = require("easy-commands.impl.util")
local editor = require("easy-commands.impl.util.editor")
local M = {}

M.QuitNvim = "qa!"

-- https://github.com/sindrets/diffview.nvim/issues/215#issuecomment-1250070954
M.DiffWithClipboard = {
	callback = function()
		local clipboard = vim.fn.getreg("*", 0, true) --[[@as string[] ]]
		local selected = vim.fn.split(editor.getSelectedText(), "\n")

		vim.cmd("tabnew")
		local selected_bufnr = vim.api.nvim_get_current_buf()
		local selectedName = vim.fn.tempname() .. "/selected"
		vim.api.nvim_buf_set_name(0, selectedName)
		vim.bo.buftype = "nofile"
		vim.api.nvim_buf_set_lines(selected_bufnr, 0, -1, false, selected)

		vim.cmd("enew")
		local clipboard_bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_name(0, vim.fn.tempname() .. "/clipboard | selected")
		vim.bo.buftype = "nofile"
		vim.api.nvim_buf_set_lines(clipboard_bufnr, 0, -1, false, clipboard)

		vim.cmd("vertical diffsplit " .. vim.fn.fnameescape(selectedName))
		vim.cmd("wincmd p")
		-- TODO: Close buffer automatically
	end,
	allow_visual_mode = true,
}

M.FormatCode = "lua vim.lsp.buf.format { async = true }"
M.NoHighlight = "nohl"

function M.CloseWindowOrBuffer()
	local isOk, _ = pcall(vim.cmd, "close")

	if not isOk then
		vim.cmd("bd")
	end
end

function M.CopyBufAbsPath()
	local buffer_path = vim.fn.expand("%:p")
	util.CopyToSystemClipboard(buffer_path)
end

function M.CopyBufAbsDirPath()
	local buffer_dir_path = vim.fn.expand("%:p:h")
	util.CopyToSystemClipboard(buffer_dir_path)
end

function M.CopyProjectDir()
	local project_path = editor.find_project_path()
	if project_path then
		util.CopyToSystemClipboard(project_path)
	end
end

function M.CopyBufRelativePath()
	local buf_relative_path = editor.get_buf_relative_path()
	util.CopyToSystemClipboard(buf_relative_path)
end

function M.CopyBufRelativeDirPath()
	util.CopyToSystemClipboard(editor.get_buf_relative_dir_path())
end

function M.CopyCdCommand()
	local cmd = "cd " .. editor.get_buf_abs_dir_path()
	vim.print(cmd)
	require("easy-commands.impl.util.base.sys").CopyToSystemClipboard(cmd)
end

function M.CopyFilename()
	util.CopyToSystemClipboard(editor.get_buf_filename())
end

function M.CopyCurrentLine()
	local line = vim.fn.getline(".")
	vim.fn.setreg("+", line, "c")
end

function M.DeleteCurrentFile()
	local filepath = editor.get_buf_abs_path()
	local confirm = vim.fn.input("Delete file: " .. filepath .. "? (y/n): ")
	local bufnr = vim.fn.bufnr("%")
	vim.api.nvim_buf_delete(bufnr, { force = true })
	if confirm == "y" then
		os.remove(filepath)
	end
end

M.SortLines = "sort"

return M

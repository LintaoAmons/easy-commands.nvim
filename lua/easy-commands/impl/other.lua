local editor = require("easy-commands.impl.util.editor")
local util = require("easy-commands.impl.util")
---@type EasyCommand.Command[]
local M = {
  {
    name = "FormatCode",
    callback = "lua vim.lsp.buf.format { async = true }",
  },
  {
    name = "QuitNvim",
    callback = "qa!",
    description = "just quit nvim",
  },
  {
    name = "DiffWithClipboard",
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
  },

  {
    name = "NoHighlight",
    callback = "nohl",
  },

  {
    name = "CloseWindowOrBuffer",
    callback = function()
      local isOk, _ = pcall(vim.cmd, "close")

      if not isOk then
        vim.cmd("bd")
      end
    end,
  },

  {
    name = "CopyBufAbsPath",
    callback = function()
      local buffer_path = vim.fn.expand("%:p")
      util.copy_to_system_clipboard(buffer_path)
    end,
  },

  {
    name = "CopyBufAbsDirPath",
    callback = function()
      local buffer_dir_path = vim.fn.expand("%:p:h")
      util.copy_to_system_clipboard(buffer_dir_path)
    end,
  },

  {
    name = "CopyProjectDir",
    callback = function()
      local project_path = editor.find_project_path()
      if project_path then
        util.copy_to_system_clipboard(project_path)
      end
    end,
  },

  {
    name = "CopyBufRelativePath",
    callback = function()
      local buf_relative_path = editor.buf.read.get_buf_relative_path()
      util.copy_to_system_clipboard(buf_relative_path)
    end,
  },

  {
    name = "CopyBufRelativeDirPath",
    callback = function()
      util.copy_to_system_clipboard(editor.buf.read.get_buf_relative_dir_path())
    end,
  },

  {
    name = "CopyCdCommand",
    callback = function()
      local cmd = "cd " .. editor.buf.read.get_buf_abs_dir_path()
      require("easy-commands.impl.util.base.sys").copy_to_system_clipboard(cmd)
    end,
  },

  {
    name = "CopyFilename",
    callback = function()
      util.copy_to_system_clipboard(editor.buf.read.get_buf_filename())
    end,
  },

  {
    name = "CopyCurrentLine",
    callback = function()
      local line = vim.fn.getline(".")
      vim.fn.setreg("+", line, "c")
    end,
  },

  {
    name = "DeleteCurrentFile",
    callback = function()
      local filepath = editor.buf.read.get_buf_abs_path()
      local confirm = vim.fn.input("Delete file: " .. filepath .. "? (y/n): ")
      local bufnr = vim.fn.bufnr("%")
      vim.api.nvim_buf_delete(bufnr, { force = true })
      if confirm == "y" then
        os.remove(filepath)
      end
    end,
  },

  {
    name = "SortLines",
    callback = "sort",
  },

  {
    name = "TempKeyBinding",
    callback = require("easy-commands.impl.other.tmp_keybinding").temp_keybinding,
    description = "Create temporary keybinding",
  },
}

return M

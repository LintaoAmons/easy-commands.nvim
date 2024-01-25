local function goToDefinitionInSplit()
  local buffer = require("easy-commands.impl.util.editor").window
  buffer.close_all_other_windows()
  buffer.splitWindow("virtical")
  vim.api.nvim_exec2("Lspsaga goto_definition")
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
    name = "GotoFunctionName",
    callback = "AerialPrev",
    dependencies = { "https://github.com/stevearc/aerial.nvim" },
  },
  {
    name = "GoToDefinitionInSplit",
    callback = goToDefinitionInSplit,
    description = "enhances code navigation and exploration in Neovim by focusing on a specific symbol and opening its definition in a right split.",
  },
  {
    name = "GoToDefinitionSmart",
    callback = function()
      local mode = vim.g.easy_command_dt_mode or "current_window"
      if mode == "current_window" then
        local windowCount = require("easy-commands.impl.util.editor").tab.countWindows()

        if windowCount == 1 then
          vim.api.nvim_command("GoToDefinition")
        else
          goToDefinitionInSplit()
        end
      else
        vim.api.nvim_command("GoToDefinition")
      end
    end,
    description = "Switch the GoToDefinition commands' behaviour (in current buf | in split)",
  },
  {
    name = "GoToDefinitionModeSwitch",
    callback = function()
      local mode = vim.g.easy_command_dt_mode or "current_window"
      if mode == "current_window" then
        vim.g.easy_command_dt_mode = "split"
      else
        vim.g.easy_command_dt_mode = "current_window"
      end
    end,
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
    name = "FindFileInDir",
    callback = "Telescope dir find_files",
    description = "find files in directory",
  },
  {
    name = "GrepInDir",
    callback = "Telescope dir live_grep",
    description = "find content in directory",
  },

  {
    name = "ToggleOutline",
    callback = "AerialNavToggle",
    dependencies = { "https://github.com/stevearc/aerial.nvim" },
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
    name = "MaximiseWindow",
    callback = function()
      require("easy-commands.impl.util.editor").window.close_all_other_windows({
        "filesystem", -- neo-tree
        "Trouble",
      })
    end,
  },
  {
    name = "MaximiseWindowAsPopup",
    callback = function()
      local api = vim.api

      -- Get the current buffer
      local current_buf = api.nvim_get_current_buf()

      -- Get the editor's dimensions
      local win_width = api.nvim_get_option("columns")
      local win_height = api.nvim_get_option("lines")

      -- Define the floating window options
      local opts = {
        style = "minimal",
        relative = "editor",
        height = win_height - 6,
        width = win_width - 10,
        row = 2,
        col = 3,
        border = "rounded",
      }

      -- Create the floating window with the current buffer
      api.nvim_open_win(current_buf, true, opts)

      -- Set the buffer's modifiable option to true
      api.nvim_buf_set_option(current_buf, "modifiable", true)
    end,
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
    name = "ToggleTwoSplitMode",
    callback = require("easy-commands.impl.navigation.split_vertical").toggle_two_split_mode,
  },
  {
    name = "SplitVertically",
    callback = require("easy-commands.impl.navigation.split_vertical").easy_command_split,
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

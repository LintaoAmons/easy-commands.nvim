local M = {}
function M.temp_keybinding()
  -- Step 1: Ask the user to choose a mode
  local modes = { "n: Normal", "i: Insert", "v: Visual", "x: Visual-Line", "t: Terminal" } -- Modes with descriptions
  vim.ui.select(modes, { prompt = "Choose a mode:", default = "n: Normal" }, function(choice)
    if choice then
      -- Extract the mode identifier (first character of the choice)
      local mode_selected = choice:sub(1, 1)

      -- Fetch all Neovim commands
      local all_commands = vim.api.nvim_get_commands({})
      local command_names = {}
      for name, _ in pairs(all_commands) do
        table.insert(command_names, name)
      end

      -- Step 2: Ask the user to choose a command from the list of all commands
      vim.ui.select(command_names, { prompt = "Choose a command:" }, function(command_selected)
        if command_selected then
          -- Step 3: Ask the user to input the shortcut
          vim.ui.input({ prompt = "Enter the shortcut key: e.g. \\a" }, function(key)
            if key then
              -- Set the keymap for the selected mode and command
              vim.api.nvim_set_keymap(
                mode_selected,
                key,
                ":" .. command_selected .. "<CR>",
                { noremap = true, silent = true }
              )
              print("Keybinding set:", mode_selected, key, command_selected)
            end
          end)
        end
      end)
    end
  end)
end

return M

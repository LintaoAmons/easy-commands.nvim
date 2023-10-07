## A collection of intuitive, easily searchable,and ready-to-use commands.

## Why this plugin?

Something like `IDEA`'s `Find Actions` or `Vscode`'s `Show All Commands` or `Obsidian`'s `Open Commands`.

<p align="left">
<img src="https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/527c0f7b-9c5c-483b-9bed-11c9efdfea6c" width="49%">
<img src="https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/fcdb8643-3193-48b6-83f2-77016a4ed278" width="49%">
</p>

![image](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/a067ad14-3665-49a9-91fe-3fc06d20794b)

<details>
<summary>READ MORE REASON</summary>
  
- Stability!
  - Commands acting like an interface layer can remain stable for your own workflow.
    - Neovim and its community are evolving rapidly, you may use different plugin to achieve to same goal in your workflow
    - However, switch plugins and rebind the keymappings can be time-consuming and cumbersome
    - Therefore, as long as your workflow remains the same, you can map abstract commands to your keys and care less about the actual implementation.
- Readable and Searchable commands
- Best solution to achieve one specific command (tring to be).
  - Sometimes it may be difficult for newcomers to find a nice plugin to perform an action, but you can search for commands and look into the underlying implementation to get an idea of what plugin you can use.
- Save your key mappings, but still make them easy to reach and use.
  - Not every command is frequently used. You don't need to map everything to a key binding, but you can still search for and trigger it when you need it once in a while.

</details>

## Install & Config

using your favorate plugin manager, for example [lazy.nvim](https://github.com/folke/lazy.nvim)

- Simple config

```lua
{
  "LintaoAmons/easy-commands.nvim",
  event = "VeryLazy",
  opts = {},
}
```

- Detailed config
  - disabledCommands: You can disable the commands you don't want
  - aliases: You can have a alias to a specific command
  - myCommands: @type EasyCommand.Command[]
    - You can add your own commands
    - You can overwrite the current implementation
    - You can use the utils provided by the plugin to build your own command
    - Welcome to share your awesome commands back to the plugin

```lua
{
  "LintaoAmons/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
    require("easy-commands").setup({
      disabledCommands = { "CopyFilename" }, -- You can disable the commands you don't want

      aliases = { -- You can have a alias to a specific command
        { from = "GitListCommits", to = "GitLog"},
      },

      -- It always welcome to send me back your good commands and usecases
      ---@type EasyCommand.Command[]
      myCommands = {
        -- You can add your own commands
        {
          name = "MyCommand",
          callback = 'lua vim.print("easy command user command")',
          description = "A demo command definition",
        },
        -- You can overwrite the current implementation
        {
          name = "EasyCommand",
          callback = 'lua vim.print("Overwrite easy-command builtin command")',
          description = "The default implementation is overwrited",
        },
        -- You can use the utils provided by the plugin to build your own command
        {
          name = "CopyCdCommand",
          callback = function()
            local editor = require("easy-commands.impl.util.editor")
            local cmd = "cd " .. editor.get_buf_abs_dir_path()
            vim.print(cmd)
            require("easy-commands.impl.util.base.sys").CopyToSystemClipboard(cmd)
          end,
          description = "Copy the buffer abs path to system clipboard",
        },
      },
    })
  end,
}
```

## Commands

Run `InspectCommand` to check all the commands that provided by easy-commands, and find the path of definition which you can further check

Or you can find all the commands it provided at https://github.com/LintaoAmons/easy-commands.nvim/blob/main/lua/easy-commands/names.lua

- [CommandUsecases](./CommandUsecase.md)

## Keybindings

This plugin didn't provide any default keybindings, you can just add keybindings in any way you like.

Here's a ref of my way: https://github.com/LintaoAmons/CoolStuffes/blob/main/lazyvim/.config/nvim/lua/config/keymaps.lua

## Contribution & TODOs

> There's a lot of TODOs inside the project. It would be great if you can help to remove some of them!
> You can also share your usecase and make some GIFs and contribute to the doc

- [x] Command alias
- [ ] Record command execution times, let user find out the most uesd command so they can think about have a keybinding of those.
- [ ] Command execution log, allow user to find out the command history and copy from the stdout and stderr
- [ ] Command, keymap wizard. vim.ui.select command, vim.ui.input shortcut key, write into json file and trigger reload. Load when setup config.
- [x] Add types to commands and config
- [x] ADd Dependencies warning when call command failed
- [x] Find way to add description and show description when user search command. (Telescope picker?)

## A collection of pre-defined commands which are readable and easy to search and use

## Why this plugin?

Make neovim easier to new commer~

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

```lua
{
  -- "LintaoAmons/easy-commands.nvim",
  dir = vim.loop.os_homedir() .. "/Documents/oatnil/beta/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
    require("easy-commands").Setup({
      disabledCommands = { "CopyFilename", "FormatCode" }, -- You can disable the commands you don't want

      -- It always welcome to send me back your good commands and usecases
      ---@type EasyCommand.Command[]
      myCommands = {
        -- You can add your own commands
        {
          name = "MyCommand",
          callback = 'lua vim.print("easy command user command")',
        },
        -- You can overwrite the current implementation
        {
          name = "EasyCommand",
          callback = 'lua vim.print("Overwrite easy-command builtin command")',
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
        },
      },

      -- Each Command may have defferent config options, check out the commands to find more options.
      ["RunSelectedAndOutputWithPrePostFix"] = {
        prefix = "```lua",
        postfix = "```",
      },
    })
  end,
}
```

## Commands

You can find all the commands it provided at https://github.com/LintaoAmons/easy-commands.nvim/blob/main/lua/easy-commands/names.lua

## Keybindings

This plugin didn't provide any default keybindings, you can just add keybindings in any way you like.

Here's a ref of my way: https://github.com/LintaoAmons/CoolStuffes/blob/main/lvim/.config/lvim/lua/lintao/keymappings.lua

## Contribution & TODOs

> There's a lot of TODOs inside the project. It would be great if you can help to remove some of them!

- [x] Add types to commands and config
- [x] ADd Dependencies warning when call command failed
- [ ] Find way to add description and show description when user search command. (Telescope picker?)

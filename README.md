## A collection of intuitive, easily searchable,and ready-to-use commands.

- Don't need to bind everything to a shortcut, just search the command if you need
- Same command, same behaivour for deffirent language but the implementation details are hinding from the end user
- Your can still easily find the actual implementation by search the command names in this repo

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

## New Commands Added: MarkdownCodeBlock
> Find more usecase: [CommandUsecases](./CommandUsecase.md)

![show](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/3d2a341d-d901-4a1a-8359-466882273ebb)

## Install & Config

using your favorate plugin manager, for example [lazy.nvim](https://github.com/folke/lazy.nvim)

- Simple config

```lua
{
  "LintaoAmons/easy-commands.nvim",
  event = "VeryLazy",
  -- use tag option to stay stable. This plugin is continues updating and adding more commands into it, pin to a tag should keep you stay where you are comfortable with.
  -- tag = "v0.8.0"
}
```

### Detailed config

- disabledCommands: You can disable the commands you don't want
- aliases: You can have a alias to a specific command
- myCommands: `@type EasyCommand.Command[]`
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
          name = "JqQuery",
          callback = function()
            local sys = require("easy-commands.impl.util.base.sys")
            local editor = require("easy-commands.impl.util.editor")

            vim.ui.input(
              { prompt = 'Query pattern, e.g. `.[] | .["@message"].message`' },
              function(pattern)
                local absPath = editor.buf.read.get_buf_abs_path()
                local stdout, _, stderr = sys.run_sync({ "jq", pattern, absPath }, ".")
                local result = stdout or stderr
                editor.split_and_write(result, { vertical = true })
              end
            )
          end,
          description = "use `jq` to query current json file",
        },
      },
    })
  end,
}
```

## Commands

- Run `InspectCommand` to check all the commands that provided by easy-commands.
- Run `FindCommands`(Provided by easy-commands) or `Telescope commands` to find the commands you need.

## Keybindings

This plugin didn't provide any default keybindings, you can just add keybindings in any way you like.

Here's a ref of my way: https://github.com/LintaoAmons/CoolStuffes/blob/main/lazyvim/.config/nvim/lua/config/keymaps.lua

## CONTRIBUTING

You are very welcome to create a PR to share your personal useful command back

Don't hesitate to ask me anything about the codebase if you want to contribute.

You can contact with me by drop me an email or [telegram](https://t.me/+ssgpiHyY9580ZWFl)

## FIND MORE USER FRIENDLY PLUGINS MADE BY ME

- [scratch.nvim](https://github.com/LintaoAmons/scratch.nvim)
- [easy-commands.nvim](https://github.com/LintaoAmons/easy-commands.nvim)
- [cd-project.nvim](https://github.com/LintaoAmons/cd-project.nvim)
- [bookmarks.nvim](https://github.com/LintaoAmons/bookmarks.nvim)
- [plugin-template.nvim](https://github.com/LintaoAmons/plugin-template.nvim)

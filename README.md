## A collection of pre-defined commands which are readable and easy to search and use


## Why this plugin?

- Stability!
    - Commands should be stable. Neovim and its community are evolving rapidly, so you may switch from `nvim-tree` to `neo-tree.nvim` at some point. However, both plugins perform the same function, with only the implementation differing.
- Readable and Searchable commands
- Best solution to achieve one specific command (tring to be)
- Save your keymappings, but still easy to reach and use

<details>
<summary>Fuzzy search & Trigger</summary>
  
![fuzzyfinder and fire 1](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/445f217c-45e3-4b5c-9152-a65f69189780)

</details>

<details>
<summary>With Fzf-lua config, command will be triggered once you press enter</summary>

```lua
require 'fzf-lua'.setup({
  commands = {
    actions = { ["default"] = require 'fzf-lua'.actions.ex_run_cr }, -- fire the command once you press enter
    sort_lastused = true, -- put the lastused command at the top of the finder
  },
})
```

</details>

## Install

using your favorate plugin manager, for example [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "LintaoAmons/easy-commands.nvim",
  event = 'VimEnter',
}
```

### Config

```lua
require("easy-commands").Setup({
  disabledCommands = { "CopyFilename", "FormatCode" }, -- You can disable the commands you don't want
  myCommands = {
    ["MyCommand"] = "lua vim.print('easy command user command')", -- You can add your own commands, commands can be string | function | table
    ["EasyCommand"] = "lua vim.print('Over write easy-command builtin command')", -- You can overwrite the current implementation
  },
  ["RunSelectedAndOutputWithPrePostFix"] = { -- Each Command may have defferent config options, check out the commands to find more options.
    prefix = "```lua",
    postfix = "```",
  },
})
```

here you can check my config with lazyvim: https://github.com/LintaoAmons/CoolStuffes/blob/main/lazyvim/.config/nvim/lua/plugins/easy-commands.lua

## Commands

You can find all the commands it provided at https://github.com/LintaoAmons/easy-commands.nvim/blob/main/lua/easy-commands/names.lua

### AskChatGPT
> Dependencies: [ltoolbox](https://github.com/LintaoAmons/ltoolbox) in $PATH  

<details open>
<summary>Click to fold the preview</summary>
  
![AskChatGPT](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/7e7060d7-454f-4ef3-b1c0-80aedce5fdcd)

</details>

### RunSelectedAndOutput
> TODO: when call this command in normal mode, will run current line as cmd command and put the outcome in the next line

will run selected text as terminal cmd and show the result in the next line, also copied the result in system clipboard

<details open>
<summary>Click to fold the preview</summary>
  
![commands](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/58304424-d1c8-4ff5-99de-44c0449ec7ff)

</details>

### RunCurrentLineAndOutputWithPrePostFix

<details>
<summary>Click to fold the preview</summary>

![8d43911152321a95dd6f32e4dcc737f7394425489](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/8019a384-2161-44e6-bda8-2e85b79bbe93)

</details>

### QueryCsv
> Dependencies: [csvq](https://github.com/mithrandie/csvq) in $PATH  
> [Video Explain](https://www.bilibili.com/video/BV1Qo4y1N76t/)

<details open>
<summary>Click to fold the preview</summary>

![show](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/16da4ff8-1cff-40bd-a57f-ec857edba34f)

</details>

### ToNextCase
> Dependencies: [ltoolbox](https://github.com/LintaoAmons/ltoolbox) in $PATH
> 
> Spare one keybinding to this command to switch between all kinds of naming style

<details open>
<summary>Click to fold the preview</summary>
  
![ToNextCase](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/45f2fac9-9e99-44e7-97f1-e4631fb863a0)

</details>

### ToCamelCase | ToConstantCase | ToKebabCase | ToSnakeCase
> Dependencies: [ltoolbox](https://github.com/LintaoAmons/ltoolbox) in $PATH  

<details>
<summary>Click to fold the preview</summary>
  
![ConvertCase](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/7377b2e3-8d73-4eea-aef7-36aaea7b5a33)

</details>

## Keybindings

This plugin didn't provide any default keybindings, you can just add keybindings in any way you like.

Here's a ref of my way: https://github.com/LintaoAmons/CoolStuffes/blob/main/lvim/.config/lvim/lua/lintao/keymappings.lua

## Contribution & TODOs
> There's a lot of TODOs inside the project. It would be great if you can help to remove some of them!

- [ ] Lazyload commands implementation only when user starts to triggered it 
- [ ] Find way to add description and show description when user search command. (Telescope picker?)

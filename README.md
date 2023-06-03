A collection of pre-defined commands which are readable and easy to search and use

## Why this plugin?

To have IDEA/VSCODE etc. like of command fuzzy search experience.

Fuzzy search & Trigger

![fuzzyfinder and fire 1](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/445f217c-45e3-4b5c-9152-a65f69189780)

So you don't need to bind every to as shortcut, but still easy to reach

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

### Tweak to fit your needs

Because this plugin have many dependencies and some of them are not your choice

You can actuall fork this repo(don't forget to star firstly), and add your own commands or have your own implementation.

It's welcome to PR back your nice commands

for example by lazy.nvim
```lua
{
  dir = "path/to/the/local/fork"
  event = 'VimEnter',
}
```

## Commands

You can find all the commands it provided at https://github.com/LintaoAmons/easy-commands.nvim/blob/main/lua/easy-commands/names.lua

### RunSelectedAndOutput
> TODO: when call this command in normal mode, will run current line as cmd command and put the outcome in the next line

will run selected text as terminal cmd and show the result in the next line, also copied the result in system clipboard

<details open>
<summary>Click to fold the preview</summary>
  
![commands](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/58304424-d1c8-4ff5-99de-44c0449ec7ff)

</details>

### RunCurrentLineAndOutputWithPrePostFix

<details open>
<summary>Click to fold the preview</summary>

  ![8d43911152321a95dd6f32e4dcc737f7394425489](https://github.com/LintaoAmons/easy-commands.nvim/assets/95092244/8019a384-2161-44e6-bda8-2e85b79bbe93)

</details>

## Keybindings

This plugin didn't provide any default keybindings, you can just add keybindings in any way you like.

Here's a ref of my way: https://github.com/LintaoAmons/CoolStuffes/blob/main/lvim/.config/lvim/lua/lintao/keymappings.lua

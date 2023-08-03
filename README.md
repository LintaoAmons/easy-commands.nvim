## A collection of pre-defined commands which are readable and easy to search and use

## Why this plugin?

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

<details open>
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

````lua
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
````

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

- [ ] Add types to commands and config
- [ ] ADd Dependencies warning when call command failed
- [ ] Find way to add description and show description when user search command. (Telescope picker?)

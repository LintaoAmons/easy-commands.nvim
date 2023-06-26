local util = require("easy-commands.impl.util")
local editor = require("easy-commands.impl.util.editor")
local strings = require("easy-commands.impl.util.base.strings")
local tables = require("easy-commands.impl.util.base.table")

-- Third party dependency

local M = {}

-- cmdFunc could do some trick to the selectedText
local function Perform_cmd_to_selected_text(cmdFunc)
  local selectedText = editor.getSelectedText()
  local output = util.Call_sys_cmd(cmdFunc(selectedText))
  util.CopyToSystemClipboard(strings.trim(output))
  editor.replaceSelectedTextWithClipboard()
end

M.InlineVariable  = function()
  require("refactoring").refactor('Inline Variable')
end

M.ExtractVariable = function()
  require("refactoring").refactor('Extract Variable')
end

M.ExtractFunction = function()
  require("refactoring").refactor('Extract Function')
end

M.ToNextCase      = function()
  if vim.g.easy_command_next_case == nil then
    vim.g.easy_command_next_case = "ToCamelCase"
  end
  M[vim.g.easy_command_next_case].callback()
  local cases = { "ToCamelCase", "ToConstantCase", "ToKebabCase", "ToSnakeCase" }
  vim.g.easy_command_next_case = cases[tables.findIndex(cases, vim.g.easy_command_next_case) + 1]
end

M.ToCamelCase     = {
  callback = function()
    Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert toCamelCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

M.ToConstantCase  = {
  callback = function()
    Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert toConstantCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

M.ToKebabCase     = {
  callback = function()
    Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert ToKebabCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

M.ToSnakeCase     = {
  callback = function()
    Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert toSnakeCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

return M

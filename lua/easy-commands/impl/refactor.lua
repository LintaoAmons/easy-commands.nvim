local util = require("easy-commands.impl.util")
local refactoring = require("refactoring")
local M = {}

M.InlineVariable  = function ()
  refactoring.refactor('Inline Variable')
end

M.ExtractVariable = function ()
  refactoring.refactor('Extract Variable')
end

M.ExtractFunction = function()
  refactoring.refactor('Extract Function')
end

M.ToCamelCase = {
  callback = function()
    util.Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert toCamelCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

M.ToConstantCase = {
  callback = function()
    util.Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert toConstantCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

M.ToKebabCase = {
  callback = function()
    util.Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert ToKebabCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

M.ToSnakeCase = {
  callback = function()
    util.Perform_cmd_to_selected_text(function(selectedText)
      return 'toolbox formatConvert toSnakeCase "' .. selectedText .. '"'
    end)
  end,
  allow_visual_mode = true,
}

return M

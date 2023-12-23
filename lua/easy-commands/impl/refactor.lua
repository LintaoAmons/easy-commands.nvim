---@type EasyCommand.Command[]
local M = {
  {
    name = "Rename",
    callback = "Lspsaga rename",
    dependencies = { "https://github.com/nvimdev/lspsaga.nvim" },
  },
  {
    name = "InlineVariable",
    callback = function()
      require("refactoring").refactor("Inline Variable")
    end,
    dependencies = { "ThePrimeagen/refactoring.nvim" },
  },
  {
    name = "ExtractVariable",
    callback = function()
      require("refactoring").refactor("Extract Variable")
    end,
    dependencies = { "ThePrimeagen/refactoring.nvim" },
  },
  {
    name = "ExtractFunction",
    callback = function()
      require("refactoring").refactor("Extract Function")
    end,
    dependencies = { "ThePrimeagen/refactoring.nvim" },
  },
}

return M

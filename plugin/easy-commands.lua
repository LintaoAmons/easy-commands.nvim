if vim.fn.has("nvim-0.7.0") == 0 then
  vim.api.nvim_err_writeln("easy-commands requires at least nvim-0.7")
  return
end

-- make sure this file is loaded only once
if vim.g.loaded_easy_commands == 1 then
  return
end
vim.g.loaded_easy_commands = 1

require("easy-commands").setup()

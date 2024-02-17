local editor = require("easy-commands.impl.util.editor")
local strings = require("easy-commands.impl.util.base.strings")

local function first_terminal_bring_up_front()
  local terminal = editor.buf.read.get_first_visible_terminal()
end

local send_selected_to_terminal_and_run = function()
  local terminal = editor.buf.read.get_first_visible_terminal()
  local selected = editor.getSelectedText()
  editor.buf.write.send_to_terminal_buf(terminal.id, selected)
end

local function sent_to_terminal_and_run()
  vim.ui.input({
    prompt = "Enter your command",
  }, function(cmd)
    local terminal = editor.buf.read.get_first_visible_terminal()
    editor.buf.write.send_to_terminal_buf(terminal.id, cmd)
  end)
end

local function send_line_to_terminal_and_run()
  local line = editor.get_current_line()
  local terminal = editor.buf.read.get_first_visible_terminal()
  editor.buf.write.send_to_terminal_buf(terminal.id, line)
  vim.notify("line sended to terminal " .. terminal.id)
end

local function run_shell_at_current_buffer_dir()
  vim.ui.input({ prompt = "Enter your command" }, function(cmd)
    if not cmd or cmd == "" then
      return
    end
    local alias = vim.g.easy_command_cmd_alias
      or {
        ["gaa"] = "git add .",
        ["grhh"] = "git reset --hard HEAD",
        ["gst"] = "git status",
        ["gp"] = "git push",
        ["gup"] = "git pull",
      }

    local dir = editor.buf.read.get_buf_abs_dir_path()
    local output = vim.fn.system("cd " .. dir .. " && " .. (alias[cmd] or cmd))
    local created = editor.window.new_popup_window(strings.split_into_lines(output))
    vim.keymap.set({ "v", "n" }, "q", function()
      vim.api.nvim_win_close(created.win, true)
    end, {
      noremap = true,
      silent = true,
      nowait = true,
      buffer = created.buf,
    })
    vim.keymap.set({ "v", "n" }, "<CR>", function()
      vim.api.nvim_win_close(created.win, true)
    end, {
      noremap = true,
      silent = true,
      nowait = true,
      buffer = created.buf,
    })
  end)
end

return {
  send_selected_to_terminal_and_run = send_selected_to_terminal_and_run,
  sent_to_terminal_and_run = sent_to_terminal_and_run,
  send_line_to_terminal_and_run = send_line_to_terminal_and_run,
  run_shell_at_current_buffer_dir = run_shell_at_current_buffer_dir,
}

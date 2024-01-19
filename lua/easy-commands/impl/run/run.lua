local send_selected_to_terminal_and_run = function()
  local editor = require("easy-commands.impl.util.editor")
  local terminal = editor.buf.read.get_first_terminal()
  local selected = editor.getSelectedText()
  editor.buf.write.send_to_terminal(terminal.id, selected)
end

local function sent_to_terminal_and_run()
  vim.ui.input({
    prompt = "Type your cmd",
  }, function(cmd)
    local editor = require("easy-commands.impl.util.editor")
    local terminal = editor.buf.read.get_first_terminal()
    editor.buf.write.send_to_terminal(terminal.id, cmd)
  end)
end

local function send_line_to_terminal_and_run()
  local editor = require("easy-commands.impl.util.editor")
  local line = editor.get_current_line()
  local terminal = editor.buf.read.get_first_terminal()
  editor.buf.write.send_to_terminal(terminal.id, line)
end

return {
  send_selected_to_terminal_and_run = send_selected_to_terminal_and_run,
  sent_to_terminal_and_run = sent_to_terminal_and_run,
  send_line_to_terminal_and_run = send_line_to_terminal_and_run,
}

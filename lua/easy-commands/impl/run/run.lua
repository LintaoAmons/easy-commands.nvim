local terminal_send_cmd = function()
  local editor = require("easy-commands.impl.util.editor")
  local terminal = editor.buf.read.get_first_terminal()
  local selected = editor.getSelectedText()
  editor.buf.write.send_to_terminal(terminal.id, selected)
end

return {
  terminal_send_cmd = terminal_send_cmd,
}

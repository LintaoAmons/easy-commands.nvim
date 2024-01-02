---Stash with comments
local stash = function()
  local sys = require("easy-commands.impl.util.base.sys")
  vim.ui.input({ prompt = "Enter your STASH conment message" }, function(msg)
    sys.run_sync({ "git", "stash", "-m", msg }, ".")
    vim.cmd("e") -- refresh buffer
  end)
end

local Git = {
  stash = stash
}

return Git

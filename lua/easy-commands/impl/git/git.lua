local commit = function()
  vim.ui.input({ prompt = "Commit msg: " }, function(msg)
    local sys = require("easy-commands.impl.util.base.sys")
    sys.run_sync({ "git", "commit", "-m", msg }, ".")
  end)
end
---Stash with comments
local stash = function()
  local sys = require("easy-commands.impl.util.base.sys")
  vim.ui.input({ prompt = "Enter your STASH conment message" }, function(msg)
    sys.run_sync({ "git", "stash", "-m", msg }, ".")
    vim.cmd("e") -- refresh buffer
  end)
end

local Git = {
  stash = stash,
  commit = commit,
}

return Git

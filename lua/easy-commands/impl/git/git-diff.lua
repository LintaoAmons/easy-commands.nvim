local function diff_current_file_with_branch()
  local sys = require("easy-commands.impl.util.base.sys")
  local branches, _, _ =
    sys.run_sync({ "git", "branch", "--list", "--format=%(refname:short)" }, ".")

  vim.ui.select(branches, {
    prompt = "Select a branch:",
    kind = "branch",
  }, function(branch_name)
    local filename = require("easy-commands.impl.util.editor").buf.read.get_buf_relative_path()
    vim.cmd("DiffviewOpen " .. branch_name .. " -- " .. filename)
  end)
end

local function diff_branches()
  local sys = require("easy-commands.impl.util.base.sys")
  local branches, _, _ =
    sys.run_sync({ "git", "branch", "--list", "--format=%(refname:short)" }, ".")

  vim.ui.select(branches, {
    prompt = "Select branch 1:",
  }, function(branch1)
    for i, value in ipairs(branches) do
      if value == branch1 then
        table.remove(branches, i)
        break
      end
    end

    vim.ui.select(branches, {
      prompt = "Select branch 2:",
    }, function(branch2)
      vim.cmd("DiffviewOpen " .. branch1 .. ".." .. branch2)
    end)
  end)
end

local function diff_commits()
  local sys = require("easy-commands.impl.util.base.sys")
  local strings = require("easy-commands.impl.util.base.strings")
  local commmits, _, _ = sys.run_sync({ "git", "log", "--oneline" }, ".")

  local parsedCommit = {}
  for index, value in ipairs(commmits) do
    local splited = strings.split(value, " ")
    local commit = { sha = splited[1], msg = table.concat(splited, " ", 2) }
    parsedCommit[index] = commit
  end

  vim.ui.select(parsedCommit, {
    prompt = "Select the diff commits",
    format_item = function(item)
      return string.format("%-10s ", item.sha) .. item.msg
    end,
  }, function(commit1)
    vim.ui.select(parsedCommit, {
      prompt = "Select the diff commits",
      format_item = function(item)
        return string.format("%-10s ", item.sha) .. item.msg
      end,
    }, function(commit2)
      vim.cmd("DiffviewOpen " .. commit1.sha .. ".." .. commit2.sha)
    end)
  end)
end

return {
  diff_branches = diff_branches,
  diff_current_file_with_branch = diff_current_file_with_branch,
  diff_commits = diff_commits,
}

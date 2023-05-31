local M = {}

M.GitDiff = "DiffviewOpen"
-- M.GitCommit =
M.GitStatus = "FzfLua git_status"
M.GitStash = "!git stash"
M.GitStashPop = "!git stash pop"
M.GitPush = "!git push"
M.GitListCommits = "DiffviewFileHistory"
M.GitListCurrentFileCommits = "DiffviewFileHistory %"
M.GitNextHunk = "lua require 'gitsigns'.next_hunk({navigation_message = false})"
M.GitPrevHunk = "lua require 'gitsigns'.prev_hunk({navigation_message = false})"
-- M.GitResetHunk =
M.GitListBranches =  "FzfLua git_branches"

return M

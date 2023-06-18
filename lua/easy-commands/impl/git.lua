local M = {}

M.GitDiff = "DiffviewOpen"
M.GitStatus = "FzfLua git_status"
M.GitStash = "!git stash"
M.GitStashPop = "!git stash pop"
M.GitPush = "!git push"
-- M.GitCommit = TODO: 
M.GitListCommits = "DiffviewFileHistory"
M.GitListCurrentFileCommits = "DiffviewFileHistory %"
M.GitNextHunk = "lua require 'gitsigns'.next_hunk({navigation_message = false})"
M.GitPrevHunk = "lua require 'gitsigns'.prev_hunk({navigation_message = false})"
M.GitResetHunk = "lua require 'gitsigns'.reset_hunk()"
M.GitListBranches = "FzfLua git_branches"
M.BlameLine = "lua require 'gitsigns'.blame_line()"
M.ResetBuffer = "lua require 'gitsigns'.reset_buffer()"
M.GitLazygit = "lua require 'lvim.core.terminal'.lazygit_toggle()"

return M

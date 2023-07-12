local M = {}

M.GitDiff = "DiffviewOpen"
M.GitStatus = "Telescope git_status"
M.GitStash = "!git stash"
M.GitStashPop = "!git stash pop"
M.GitPush = "!git push"
-- M.GitCommit = TODO:
M.GitListCommits = "DiffviewFileHistory"
M.GitListCommitsOfCurrentFile = "DiffviewFileHistory %"
M.GitNextHunk = "lua require 'gitsigns'.next_hunk({navigation_message = false})"
M.GitPrevHunk = "lua require 'gitsigns'.prev_hunk({navigation_message = false})"
M.GitResetHunk = "lua require 'gitsigns'.reset_hunk()"
M.GitListBranches = "FzfLua git_branches"
M.GitBlameLine = "lua require 'gitsigns'.blame_line()"
M.GitResetBuffer = "lua require 'gitsigns'.reset_buffer()"
M.GitLazygit = "lua require 'lvim.core.terminal'.lazygit_toggle()"

return M

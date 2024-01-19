---@type EasyCommand.Command[]
local M = {
  {
    name = "GitDiff",
    callback = "DiffviewOpen",
    dependencies = { "https://github.com/sindrets/diffview.nvim" },
  },

  {
    name = "GitDiffBranches",
    callback = require("easy-commands.impl.git.git-diff").diff_branches,
    dependencies = { "https://github.com/sindrets/diffview.nvim" },
  },

  {
    name = "GitDiffCommits",
    callback = require("easy-commands.impl.git.git-diff").diff_commits,
    dependencies = { "https://github.com/sindrets/diffview.nvim" },
  },

  {
    name = "GitDiffCurrentFileWithBranch",
    callback = require("easy-commands.impl.git.git-diff").diff_current_file_with_branch,
    dependencies = { "https://github.com/sindrets/diffview.nvim" },
  },

  {
    name = "GitDiffCurrentBranchHistory",
    callback = "DiffviewFileHistory",
    dependencies = { "https://github.com/sindrets/diffview.nvim" },
  },

  {
    name = "GitDiffStashHistory",
    callback = "DiffviewFileHistory -g --range=stash",
    dependencies = { "https://github.com/sindrets/diffview.nvim" },
  },

  {
    name = "GitDiffCurrentFileHistory",
    callback = "DiffviewFileHistory %",
    dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
  },

  {
    name = "GitStatus",
    callback = "Telescope git_status",
    dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
  },

  {
    name = "GitStash",
    callback = require("easy-commands.impl.git.git").stash,
  },

  {
    name = "GitStashPop",
    callback = "!git stash pop",
  },
  {
    name = "GitPush",
    callback = "!git push",
  },

  {
    name = "GitCheckout",
    callback = "Telescope git_branches",
    dependencies = { "https://github.com/nvim-telescope/telescope.nvim" },
  },

  {
    name = "GitCommit",
    callback = require("easy-commands.impl.git.git").commit,
    description = "Commit current staged changes with commit msg",
  },

  {
    name = "GitLog",
    callback = "Flog -all",
    dependencies = { "https://github.com/rbong/vim-flog" },
  },

  {
    name = "GitNextHunk",
    callback = "lua require 'gitsigns'.next_hunk({navigation_message = false})",
    dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
  },
  {
    name = "GitPrevHunk",
    callback = "lua require 'gitsigns'.prev_hunk({navigation_message = false})",
    dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
  },
  {
    name = "GitResetHunk",
    callback = "lua require 'gitsigns'.reset_hunk()",
    dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
  },

  {
    name = "GitAddHunk",
    callback = "Gitsigns stage_hunk",
    dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
  },
  {
    name = "GitBlameLine",
    callback = "lua require 'gitsigns'.blame_line()",
    dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
  },
  {
    name = "GitResetBuffer",
    callback = "lua require 'gitsigns'.reset_buffer()",
    dependencies = { "https://github.com/lewis6991/gitsigns.nvim" },
  },
}

return M

-- HACK: This list contains all the commands this plugin want to have
-- Some of them many not have Implementation yet
-- Some may have third party dependencies
local commands = {
  git = { -- TODO: README
    "GitDiff",
    "GitStatus",
    "GitCommit",
    "GitStash",
    "GitStashPop",
    "GitPush",
    "GitListCommits",
    "GitListCurrentFileCommits",
    "GitListCommitsOfSelectedLines",
    "GitNextHunk",
    "GitPrevHunk",
    "GitResetHunk",
    "GitListBranches",
    "BlameLine",
    "ResetBuffer",
    "GitLazygit",
  },
  refactor = {
    "ExtractFunction",
    "ExtractVariable",
    "InlineVariable",

    "ToNextCase",
    "ToCamelCase",
    "ToConstantCase",
    "ToKebabCase",
    "ToSnakeCase",
  },
  explorer = {
    "ExplorerLocateCurrentFile",
  },
  navigation = {
    "LspFinder",
    "ToggleOutline",
    "GoToDefinition",
    "GoToTestFile",

    "OpenChangedFiles",
    "OpenRecentFiles",
    "LeapJump",
    "MaximiseBuffer",

    "TabNext",
    "TabPrev",
    "TabClose",
    "TabNew",

    "BufferNext",
    "BufferPrev",

    "SplitVertically",
    "MaximiseBufferAndCloseOthers",
    "IncreaseSplitWidth",
    "DecreaseSplitWidth",

    "Mark",
    "MarkList",
    "MarkNext",
    "MarkPrev",

    "FoldAll",
    "UnFoldAll",
  },
  test = {
    "TestRunNearest",
    "TestRunCurrentFile",
    "TestRunLast",
    "TestToggleOutputPanel",
    "TestDebugNearest",
    "GoToTestFile",
  },
  finder = {
    "FindFiles",
    "FindCommands",
    "FindKeymappins",
    "FindInWholeProject", -- TODO: If in visual mode, find with selected text
    "FzfLuaBuiltin",
  },
  run = {
    "RunCurrentBuffer",
    "RunLiveToggle",
    "RunCurrentLineAndOutput",
    "RunCurrentLineAndOutputWithPrePostFix",
    "RunSelectedAndOutput",
    "RunSelectedAndOutputWithPrePostFix",
    "RunSelectedAndReplace",

    "QueryCsv"
  },
  other = {
    "QuitNvim",
    "DiffWithClipboard",
    "FormatCode",
    "NoHighlight",
    "CloseWindowOrBuffer",
    "CopyBufAbsPath", -- TODO: README
    "CopyBufAbsDirPath",
    "CopyProjectDir",
    "CopyBufRelativePath",
    "CopyBufRelativeDirPath",
  },
  helper = {
    "PrintSelected", -- TODO:
  },
  nvim = {
    "SourceCurrentBuffer",
  },
  ai = {
    "AskChatGPT",
    "AskChatGPTWithSelection",
  }
}

local result = {}
for _, command_group in pairs(commands) do
  for _, command in ipairs(command_group) do
    table.insert(result, command)
  end
end

return result

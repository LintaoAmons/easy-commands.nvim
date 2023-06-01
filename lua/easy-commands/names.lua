local commands = {
  git = {
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
    "GitChangedFiles",
  },
  refactor = {
    "ExtractFunction",
    "ExtractVariable",
    "InlineVariable",

    "ToCamelCase",
    "ToConstantCase",
    "ToKebabCase",
    "ToSnakeCase",
  },
  explorer = {
    "ExplorerLocateCurrentFile",
  },
  navigation = {
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
    "FindInWholeProject",
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
  },
  other = {
    "QuitNvim",
    "DiffWithClipboard",
    "FormatCode",
    "NoHighlight",
    "ToggleOutline",
    "CloseWindowOrBuffer",
    "CopyBufAbsPath",
    "CopyBufAbsDirPath",
    "CopyProjectDir",
    "CopyBufRelativePath",
    "CopyBufRelativeDirPath",
  },
  nvim = {
    "SourceCurrentBuffer",
  },
  ai = {
    "AskChatGPT"
  }
}

local result = {}
for _, command_group in pairs(commands) do
  for _, command in ipairs(command_group) do
    table.insert(result, command)
  end
end

return result

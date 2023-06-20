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
    "GitBlameLine",
    "GitResetBuffer",
    "GitLazygit",
    "GitPeek", -- TODO:
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
    "SwitchProject",
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
  finder = { -- HACK: include finder, search and replace
    "FindFiles",
    "FindCommands",
    "FindKeymappins",
    "FindInProject", -- TODO: If in visual mode, find with selected text
    "SearchInProject",
    "SearchOrReplace",
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

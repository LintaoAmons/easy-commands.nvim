-- HACK: This list contains all the commands this plugin want to have
-- Some of them many not have Implementation yet
-- Some may have third party dependencies

local commands = {
  git = { -- TODO: README
    "GitCheckout",
    "GitLog",
    "GitStatus",
    "GitCommit",
    "GitStash",
    "GitStashPop",
    "GitPush",

    "GitDiff",
    "GitDiffBranches",
    "GitDiffCommits",
    "GitDiffCurrentFileHistory",
    "GitDiffCurrentFileWithBranch",
    "GitDiffCurrentBranchHistory",
    "GitDiffStashHistory",

    "GitListCommitsOfCurrentFile",
    "GitListCommitsOfSelectedLines", -- TODO: impl

    "GitNextHunk",
    "GitPrevHunk",
    "GitResetHunk",
    "GitAddHunk",

    "GitBlameLine",
    "GitResetBuffer",
  },
  debug = {
    "ToggleDebugUI",
    "DebugStartOrContinue",
    "DebugToggleBreakpoint",
    "DebugStepOver",
    "DebugStepInto",
    "DebugStop",
    "DebugWidget",
    "DebugLastTest",
    "DebugTest",
  },
  refactor = {
    "ExtractFunction",
    "ExtractVariable",
    "InlineVariable",
    "Rename",
  },
  explorer = {
    "ToggleExplorer",
    "ExplorerLocateCurrentFile",
    "OpenInFinder",
    "OpenBySystemDefaultApp",
  },
  navigation = {
    "LspFinder",
    "ToggleOutline",
    "GoToDefinition",
    "GoToDefinitionSmart",
    "GoToDefinitionModeSwitch",
    "GoToDefinitionInSplit",
    "GoToTestFile",
    "GoToFunctionName",

    "OpenChangedFiles",
    "OpenRecentFiles",
    "OpenRecentFilesInAllPlaces",
    "FindFileInDir",
    "GrepInDir",

    "MaximiseWindow",
    "MaximiseWindowAsPopup",

    "TabNext",
    "TabPrev",
    "TabClose",
    "TabNew",

    "BufferNext",
    "BufferPrev",

    "ToggleTwoSplitMode",
    "SplitVertically",
    "Split",
    "IncreaseSplitWidth",
    "DecreaseSplitWidth",

    "Mark",
    "MarkList",
    "MarkNext",
    "MarkPrev",

    "FoldAll",
    "UnFoldAll",

    "PeekDefinition",
    "PeekTypeDefinition",
    "PeekGitChange",
  },
  test = {
    "TestRunNearest",
    "TestRunCurrentFile",
    "TestRunLast",
    "TestToggleOutputPanel",
    "GoToTestFile",
    "TestPlugin",
    "TerminalCdToBufferDir",
  },
  finder = { -- HACK: include finder, search and replace
    "FindFiles",
    "FindCommands",
    "FindKeymappins",
    "FindInProject", -- TODO: If in visual mode, find with selected text
    "SearchInProject",
    "SearchOrReplace",
    "SearchOrReplaceInCurrentFile",
    "FzfLuaBuiltin",
  },
  run = {
    "Hurl",
    "HurlSelected",
    "RunCurrentBuffer",
    "RunLiveToggle",
    "RunShellCurrentLine",
    "RunShellAtBufDir",
    "TriggerLastRun", -- TODO: trigger last run or debug command.
    "JqQuery",
    "DistinctLines",
    "TrimLine",
    "CsvPrettify",

    "SendToTerminalAndRun",
    "SendLineToTerminalAndRun",

    "SendSelectedToTerminalAndRun",

    -- "RunCurrentLineAndOutputWithPrePostFix",
    "RunSelectedAndOutput",
    -- "RunSelectedAndOutputWithPrePostFix",
    -- "RunSelectedAndReplace",
  },
  editor = {
    "ShowLineDiagnostics",
    "CodeAction",
    "ToggleAutoSave",

    "Wrap",
    "UnWrap",
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
    "CopyFilename",
    "CopyCdCommand",
    "CopyCurrentLine",
    "SortLines",
    "DeleteCurrentFile",
    "TempKeyBinding",
  },
  helper = {
    "PrintSelected", -- TODO: use https://github.com/andrewferrier/debugprint.nvim
    "MarkdownCodeBlock",
  },
  nvim = {
    "SourceCurrentBuffer",
    "CheckKeymapDefinitions",
    "InspectCommand",
  },
  ai = {
    "AskGpt4",
    "AskChatGPTWithSelection",
  },
}

local result = {}
for _, command_group in pairs(commands) do
  for _, command in ipairs(command_group) do
    table.insert(result, command)
  end
end

return result

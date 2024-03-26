-- Clear hlgroups and set colors_name
vim.cmd.hi 'clear'
vim.g.colors_name = 'asdf'

local c_fg
local c_bg
local c_red
local c_dragonBg2
local c_dragonBg3
local c_dragonBg4
local c_dragonBg5
local c_dragonFg0
local c_dragonFg1
local c_dragonFg2
local c_dragonAsh

if vim.go.bg == 'dark' then
  c_fg = '#ffffff'
  c_bg = '#1b1b1b'

  -- c_yellow = '#dca561'
  -- c_dragonAsh = '#626462'
  -- c_dragonBg0 = '#0d0c0c'
  -- c_dragonBg1 = '#181616'
  -- c_dragonBg2 = '#201d1d'
  -- c_dragonBg3 = '#282727'
  -- c_dragonBg4 = '#393836'
  -- c_dragonBg5 = '#625e5a'
  -- c_blue = '#658594'
  -- c_blue = '#8ba4b0'
  -- c_dragonGray0 = '#a6a69c'
  -- c_dragonGray1 = '#9e9b93'
  -- c_dragonGreen0 = '#87a987'
  -- c_green = '#8a9a7b'
  -- c_red = '#c4746e'
else
  c_fg = '#1b1b1b'
  c_bg = '#ffffff'

  c_accent = '#e8e8e8'

  c_green = '#d5dcd2'
  c_red = '#e6c2c7'
  c_yellow = '#fdfd96'
  c_blue = '#d4d4f0'

  c_dragonAsh = '#a0a0a0'
  -- c_dragonBg0 = '#f9f9f9'
  c_dragonBg1 = '#ffffff'
  c_dragonBg2 = '#efefef'
  c_dragonBg3 = '#e8e8e8'
  c_dragonBg4 = '#d8d8d8'
  c_dragonBg5 = '#b0b0b0'
  -- c_red = '#a292a3'
  -- c_dragonViolet = '#373e50'
  c_dragonFg0 = '#1b1b1b'
  c_dragonFg1 = '#303030'
  c_dragonFg2 = '#787878'
  -- c_katanaGray = '#717c7c'
end

-- M.base_30 = {
--   deep_black = "#263238",
--   white = "#37474F",
--   darker_black = "#f7f7f7",
--   black = "#FFFfff", --  nvim bg
--   black2 = "#ECEFF1",
--   one_bg = "#ebebeb", -- real bg of onedark
--   one_bg2 = "#e0e0e0",
--   one_bg3 = "#d4d4d4",
--   grey = "#c4c4c4",
--   grey_fg = "#b5b5b5",
--   grey_fg2 = "#a3a3a3",
--   light_grey = "#848484",
--   faded_grey = "#8497a0",
--   pink = "#AB47BC",
--   pmenu_bg = "#673AB7",
-- }
-- stylua: ignore end
--

-- Terminal colors
-- stylua: ignore start
if vim.go.bg == 'dark' then
  vim.g.terminal_color_0  = c_bg
  vim.g.terminal_color_1  = c_bg
  vim.g.terminal_color_2  = c_accent
  vim.g.terminal_color_3  = c_green
  vim.g.terminal_color_4  = c_fg
  vim.g.terminal_color_5  = c_accent
  vim.g.terminal_color_6  = c_fg
  vim.g.terminal_color_7  = c_fg
  vim.g.terminal_color_8  = c_fg
  vim.g.terminal_color_9  = c_fg
  vim.g.terminal_color_10 = c_fg
  vim.g.terminal_color_11 = c_fg
  vim.g.terminal_color_12 = c_fg
  vim.g.terminal_color_13 = c_fg
  vim.g.terminal_color_14 = c_fg
  vim.g.terminal_color_15 = c_fg
else
  vim.g.terminal_color_0  = c_bg
  vim.g.terminal_color_1  = c_bg
  vim.g.terminal_color_2  = c_accent
  vim.g.terminal_color_3  = c_green
  vim.g.terminal_color_4  = c_fg
  vim.g.terminal_color_5  = c_accent
  vim.g.terminal_color_6  = c_fg
  vim.g.terminal_color_7  = c_fg
  vim.g.terminal_color_8  = c_fg
  vim.g.terminal_color_9  = c_fg
  vim.g.terminal_color_10 = c_fg
  vim.g.terminal_color_11 = c_fg
  vim.g.terminal_color_12 = c_fg
  vim.g.terminal_color_13 = c_fg
  vim.g.terminal_color_14 = c_fg
  vim.g.terminal_color_15 = c_fg
end
-- stylua: ignore end

local hlgroups = {
  -- UI
  ColorColumn = { bg = c_fg },
  Conceal = { bold = true, fg = c_fg },
  CurSearch = { link = 'IncSearch' },
  Cursor = { bg = c_bg, fg = c_fg },
  CursorColumn = { link = 'CursorLine' },
  CursorIM = { link = 'Cursor' },
  CursorLine = { bg = c_accent },
  CursorLineNr = { fg = c_fg, bold = true },
  DebugPC = { bg = c_fg },
  DiffAdd = { bg = c_fg },
  DiffChange = { bg = c_fg },
  DiffDelete = { fg = c_fg },
  DiffText = { bg = c_fg },
  Directory = { fg = c_fg },
  EndOfBuffer = { fg = c_fg },
  ErrorMsg = { fg = c_fg },
  FloatBorder = { fg = c_fg, bg = c_fg },
  FloatFooter = { bg = c_fg, fg = c_fg },
  FloatTitle = { bg = c_fg, fg = c_fg, bold = true },
  FoldColumn = { fg = c_dragonBg5 },
  Folded = { bg = c_dragonBg2, fg = c_lotusGray },
  Ignore = { link = 'NonText' },
  IncSearch = { bg = c_yellow, fg = c_blue },
  LineNr = { fg = c_dragonBg5 },
  MatchParen = { bg = c_dragonBg4 },
  ModeMsg = { fg = c_dragonFg2, bold = true },
  MoreMsg = { fg = c_blue },
  MsgArea = { fg = c_dragonFg1 },
  MsgSeparator = { bg = c_dragonBg1 },
  NonText = { fg = c_dragonBg5 },
  Normal = { bg = c_dragonBg1, fg = c_dragonFg0 },
  NormalFloat = { bg = c_dragonBg3, fg = c_dragonFg1 },
  NormalNC = { link = 'Normal' },
  Pmenu = { bg = c_dragonBg3, fg = c_dragonFg1 },
  PmenuSbar = { bg = c_dragonBg4 },
  PmenuSel = { bg = c_dragonBg4, fg = 'NONE' },
  PmenuThumb = { bg = c_dragonBg5 },
  PmenuBorder = { link = 'FloatBorder' },
  Question = { link = 'MoreMsg' },
  QuickFixLine = { bg = c_dragonBg3 },
  Search = { bg = c_dragonBg4 },
  SignColumn = { fg = c_dragonGray2 },
  SpellBad = { undercurl = true, sp = c_red },
  SpellCap = { undercurl = true },
  SpellLocal = { undercurl = true },
  SpellRare = { undercurl = true },
  StatusLine = { bg = c_dragonBg3, fg = c_dragonFg1 },
  StatusLineNC = { bg = c_dragonBg3, fg = c_dragonBg5 },
  StatusColumnSeparator = { fg = c_dragonBg3, nocombine = true, bg = c_dragonBg1 },
  Substitute = { bg = c_red, fg = c_dragonFg0 },
  TabLine = { link = 'StatusLineNC' },
  TabLineFill = { link = 'Normal' },
  TabLineSel = { link = 'StatusLine' },
  TermCursor = { fg = c_dragonBg1, bg = c_red },
  TermCursorNC = { fg = c_dragonBg1, bg = c_dragonAsh },
  Title = { bold = true, fg = c_blue },
  Underlined = { fg = c_blue, underline = true },
  VertSplit = { link = 'WinSeparator' },
  Visual = { bg = c_dragonBg4 },
  VisualNOS = { link = 'Visual' },
  WarningMsg = { fg = c_yellow },
  Whitespace = { fg = c_dragonBg4 },
  WildMenu = { link = 'Pmenu' },
  WinBar = { bg = 'NONE', fg = c_dragonFg1 },
  WinBarNC = { link = 'WinBar' },
  WinSeparator = { fg = c_dragonBg4 },
  lCursor = { link = 'Cursor' },

  -- Syntax
  Boolean = { fg = c_dragonOrange0, bold = true },
  Character = { link = 'String' },
  Comment = { fg = c_green },
  Constant = { fg = c_dragonOrange0 },
  Delimiter = { fg = c_dragonGray1 },
  Error = { fg = c_red },
  Exception = { fg = c_red },
  Float = { link = 'Number' },
  Function = { fg = c_blue },
  Identifier = { fg = c_dragonFg0 },
  Keyword = { fg = c_dragonViolet },
  Number = { fg = c_red },
  Operator = { fg = c_red },
  PreProc = { fg = c_red },
  Special = { fg = c_blue },
  SpecialKey = { fg = c_dragonGray2 },
  Statement = { fg = c_dragonViolet },
  String = { fg = c_green },
  Todo = { fg = c_dragonBg0, bg = c_blue, bold = true },
  Type = { fg = c_blue },

  -- Treesitter syntax
  ['@attribute'] = { link = 'Constant' },
  ['@constructor'] = { fg = c_blue },
  ['@constructor.lua'] = { fg = c_dragonViolet },
  ['@keyword.exception'] = { bold = true, fg = c_red },
  ['@keyword.import'] = { link = 'PreProc' },
  ['@keyword.luap'] = { link = '@string.regexp' },
  ['@keyword.operator'] = { bold = true, fg = c_red },
  ['@keyword.return'] = { fg = c_red, italic = true },
  ['@module'] = { fg = c_dragonOrange0 },
  ['@operator'] = { link = 'Operator' },
  ['@variable.parameter'] = { fg = c_dragonGray0 },
  ['@punctuation.bracket'] = { fg = c_dragonGray1 },
  ['@punctuation.delimiter'] = { fg = c_dragonGray1 },
  ['@markup.list'] = { fg = c_blue },
  ['@string.escape'] = { fg = c_dragonOrange0 },
  ['@string.regexp'] = { fg = c_dragonOrange0 },
  ['@markup.link.label.symbol'] = { fg = c_dragonFg0 },
  ['@tag.attribute'] = { fg = c_dragonFg0 },
  ['@tag.delimiter'] = { fg = c_dragonGray1 },
  ['@comment.error'] = { bg = c_red, fg = c_dragonFg0, bold = true },
  ['@diff.plug'] = { fg = c_green },
  ['@diff.minus'] = { fg = c_red },
  ['@markup.emphasis'] = { italic = true },
  ['@markup.environment'] = { link = 'Keyword' },
  ['@markup.environment.name'] = { link = 'String' },
  ['@markup.raw'] = { link = 'String' },
  ['@comment.info'] = { bg = c_waveAqua0, fg = c_blue, bold = true },
  ['@markup.quote'] = { link = '@variable.parameter' },
  ['@markup.strong'] = { bold = true },
  ['@markup.heading'] = { link = 'Function' },
  ['@markup.heading.1.markdown'] = { fg = c_red },
  ['@markup.heading.2.markdown'] = { fg = c_red },
  ['@markup.heading.3.markdown'] = { fg = c_red },
  ['@markup.heading.4.markdown'] = { fg = c_red },
  ['@markup.heading.5.markdown'] = { fg = c_red },
  ['@markup.heading.6.markdown'] = { fg = c_red },
  ['@markup.heading.1.marker.markdown'] = { link = 'Delimiter' },
  ['@markup.heading.2.marker.markdown'] = { link = 'Delimiter' },
  ['@markup.heading.3.marker.markdown'] = { link = 'Delimiter' },
  ['@markup.heading.4.marker.markdown'] = { link = 'Delimiter' },
  ['@markup.heading.5.marker.markdown'] = { link = 'Delimiter' },
  ['@markup.heading.6.marker.markdown'] = { link = 'Delimiter' },
  ['@comment.todo.checked'] = { fg = c_dragonAsh },
  ['@comment.todo.unchecked'] = { fg = c_red },
  ['@markup.link.label.markdown_inline'] = { link = 'htmlLink' },
  ['@markup.link.url.markdown_inline'] = { link = 'htmlString' },
  ['@comment.warning'] = { bg = c_yellow, fg = c_blue, bold = true },
  ['@variable'] = { fg = c_dragonFg0 },
  ['@variable.builtin'] = { fg = c_red, italic = true },

  -- LSP semantic
  ['@lsp.mod.readonly'] = { link = 'Constant' },
  ['@lsp.mod.typeHint'] = { link = 'Type' },
  ['@lsp.type.builtinConstant'] = { link = '@constant.builtin' },
  ['@lsp.type.comment'] = { fg = 'NONE' },
  ['@lsp.type.macro'] = { fg = c_red },
  ['@lsp.type.magicFunction'] = { link = '@function.builtin' },
  ['@lsp.type.method'] = { link = '@function.method' },
  ['@lsp.type.namespace'] = { link = '@module' },
  ['@lsp.type.parameter'] = { link = '@variable.parameter' },
  ['@lsp.type.selfParameter'] = { link = '@variable.builtin' },
  ['@lsp.type.variable'] = { fg = 'NONE' },
  ['@lsp.typemod.function.builtin'] = { link = '@function.builtin' },
  ['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' },
  ['@lsp.typemod.function.readonly'] = { bold = true, fg = c_blue },
  ['@lsp.typemod.keyword.documentation'] = { link = 'Special' },
  ['@lsp.typemod.method.defaultLibrary'] = { link = '@function.builtin' },
  ['@lsp.typemod.operator.controlFlow'] = { link = '@keyword.exception' },
  ['@lsp.typemod.operator.injected'] = { link = 'Operator' },
  ['@lsp.typemod.string.injected'] = { link = 'String' },
  ['@lsp.typemod.variable.defaultLibrary'] = { link = 'Special' },
  ['@lsp.typemod.variable.global'] = { link = 'Constant' },
  ['@lsp.typemod.variable.injected'] = { link = '@variable' },
  ['@lsp.typemod.variable.static'] = { link = 'Constant' },

  -- LSP
  LspCodeLens = { fg = c_dragonAsh },
  LspInfoBorder = { link = 'FloatBorder' },
  LspReferenceRead = { link = 'LspReferenceText' },
  LspReferenceText = { bg = c_yellow },
  LspReferenceWrite = { bg = c_yellow },
  LspSignatureActiveParameter = { fg = c_yellow },

  -- Diagnostic
  DiagnosticError = { fg = c_red },
  DiagnosticHint = { fg = c_blue },
  DiagnosticInfo = { fg = c_blue },
  DiagnosticOk = { fg = c_green },
  DiagnosticWarn = { fg = c_yellow },
  DiagnosticFloatingError = { fg = c_red },
  DiagnosticFloatingWarn = { fg = c_yellow },
  DiagnosticFloatingInfo = { fg = c_blue },
  DiagnosticFloatingHint = { fg = c_blue },
  DiagnosticFloatingOk = { fg = c_green },
  DiagnosticFloatingSuffix = { fg = c_dragonFg2 },
  DiagnosticSignError = { fg = c_red },
  DiagnosticSignHint = { fg = c_blue },
  DiagnosticSignInfo = { fg = c_blue },
  DiagnosticSignWarn = { fg = c_yellow },
  DiagnosticUnderlineError = { sp = c_red, undercurl = true },
  DiagnosticUnderlineHint = { sp = c_blue, undercurl = true },
  DiagnosticUnderlineInfo = { sp = c_blue, undercurl = true },
  DiagnosticUnderlineWarn = { sp = c_yellow, undercurl = true },
  DiagnosticVirtualTextError = { bg = c_red, fg = c_red },
  DiagnosticVirtualTextHint = { bg = c_green, fg = c_blue },
  DiagnosticVirtualTextInfo = { bg = c_winterBlue, fg = c_blue },
  DiagnosticVirtualTextWarn = { bg = c_yellow, fg = c_yellow },

  -- Filetype
  -- Git
  gitHash = { fg = c_dragonAsh },

  -- Sh/Bash
  bashSpecialVariables = { link = 'Constant' },
  shAstQuote = { link = 'Constant' },
  shCaseEsac = { link = 'Operator' },
  shDeref = { link = 'Special' },
  shDerefSimple = { link = 'shDerefVar' },
  shDerefVar = { link = 'Constant' },
  shNoQuote = { link = 'shAstQuote' },
  shQuote = { link = 'String' },
  shTestOpr = { link = 'Operator' },

  -- HTML
  htmlBold = { bold = true },
  htmlBoldItalic = { bold = true, italic = true },
  htmlH1 = { fg = c_red, bold = true },
  htmlH2 = { fg = c_red, bold = true },
  htmlH3 = { fg = c_red, bold = true },
  htmlH4 = { fg = c_red, bold = true },
  htmlH5 = { fg = c_red, bold = true },
  htmlH6 = { fg = c_red, bold = true },
  htmlItalic = { italic = true },
  htmlLink = { fg = c_blue, underline = true },
  htmlSpecialChar = { link = 'SpecialChar' },
  htmlSpecialTagName = { fg = c_dragonViolet },
  htmlString = { fg = c_dragonAsh },
  htmlTagName = { link = 'Tag' },
  htmlTitle = { link = 'Title' },

  -- Markdown
  markdownBold = { bold = true },
  markdownBoldItalic = { bold = true, italic = true },
  markdownCode = { fg = c_green },
  markdownCodeBlock = { fg = c_green },
  markdownError = { link = 'NONE' },
  markdownEscape = { fg = 'NONE' },
  markdownH1 = { link = 'htmlH1' },
  markdownH2 = { link = 'htmlH2' },
  markdownH3 = { link = 'htmlH3' },
  markdownH4 = { link = 'htmlH4' },
  markdownH5 = { link = 'htmlH5' },
  markdownH6 = { link = 'htmlH6' },
  markdownListMarker = { fg = c_yellow },

  -- Typescript
  typescriptBlock = { link = 'Comment' },

  -- Checkhealth
  healthError = { fg = c_red },
  healthSuccess = { fg = c_green },
  healthWarning = { fg = c_yellow },
  helpHeader = { link = 'Title' },
  helpSectionDelim = { link = 'Title' },

  -- Qf
  qfFileName = { link = 'Directory' },
  qfLineNr = { link = 'lineNr' },

  -- Plugins {{{2
  -- nvim-cmp
  CmpCompletion = { link = 'Pmenu' },
  CmpCompletionBorder = { link = 'FloatBorder' },
  CmpCompletionSbar = { link = 'PmenuSbar' },
  CmpCompletionSel = { bg = c_blue, fg = 'NONE' },
  CmpCompletionThumb = { link = 'PmenuThumb' },
  CmpDocumentation = { link = 'NormalFloat' },
  CmpDocumentationBorder = { link = 'FloatBorder' },
  CmpItemAbbr = { fg = c_dragonFg2 },
  CmpItemAbbrDeprecated = { fg = c_dragonAsh, strikethrough = true },
  CmpItemAbbrMatch = { fg = c_red },
  CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
  CmpItemKindClass = { link = 'Type' },
  CmpItemKindConstant = { link = 'Constant' },
  CmpItemKindConstructor = { link = '@constructor' },
  CmpItemKindCopilot = { link = 'String' },
  CmpItemKindDefault = { fg = c_katanaGray },
  CmpItemKindEnum = { link = 'Type' },
  CmpItemKindEnumMember = { link = 'Constant' },
  CmpItemKindField = { link = '@variable.member' },
  CmpItemKindFile = { link = 'Directory' },
  CmpItemKindFolder = { link = 'Directory' },
  CmpItemKindFunction = { link = 'Function' },
  CmpItemKindInterface = { link = 'Type' },
  CmpItemKindKeyword = { link = '@keyword' },
  CmpItemKindMethod = { link = 'Function' },
  CmpItemKindModule = { link = '@keyword.import' },
  CmpItemKindOperator = { link = 'Operator' },
  CmpItemKindProperty = { link = '@property' },
  CmpItemKindReference = { link = 'Type' },
  CmpItemKindSnippet = { fg = c_blue },
  CmpItemKindStruct = { link = 'Type' },
  CmpItemKindText = { fg = c_dragonFg2 },
  CmpItemKindTypeParameter = { link = 'Type' },
  CmpItemKindValue = { link = 'String' },
  CmpItemKindVariable = { fg = c_red },
  CmpItemMenu = { fg = c_dragonAsh },

  -- gitsigns
  GitSignsAdd = { fg = c_green },
  GitSignsChange = { fg = c_yellow },
  GitSignsDelete = { fg = c_red },
  GitSignsDeletePreview = { bg = c_red },

  -- fugitive
  DiffAdded = { fg = c_green },
  DiffChanged = { fg = c_yellow },
  DiffDeleted = { fg = c_red },
  DiffNewFile = { fg = c_green },
  DiffOldFile = { fg = c_red },
  DiffRemoved = { fg = c_red },
  fugitiveHash = { link = 'gitHash' },
  fugitiveHeader = { link = 'Title' },
  fugitiveStagedModifier = { fg = c_green },
  fugitiveUnstagedModifier = { fg = c_yellow },
  fugitiveUntrackedModifier = { fg = c_blue },

  -- telescope
  TelescopeMatching = { fg = c_red, bold = true },
  TelescopeNormal = { fg = c_dragonFg2, bg = c_dragonBg3 },
  TelescopePreviewNormal = { bg = c_dragonBg2 },
  TelescopePreviewBorder = { fg = c_dragonBg2, bg = c_dragonBg2 },
  TelescopeBorder = { bg = c_dragonBg3, fg = c_dragonBg3 },
  TelescopePromptNormal = { bg = c_dragonBg3 },
  TelescopePromptBorder = { fg = c_dragonBg3, bg = c_dragonBg3 },
  TelescopeResultsClass = { link = 'Structure' },
  TelescopeResultsField = { link = '@keyword.member' },
  TelescopeResultsMethod = { link = 'Function' },
  TelescopeResultsStruct = { link = 'Structure' },
  TelescopeResultsVariable = { link = '@variable' },
  TelescopeSelection = { link = 'CursorLine' },
  TelescopeSelectionCaret = { link = 'CursorLineNr' },
  TelescopeTitle = { fg = c_red },

  IndentBlanklineChar = { fg = c_dragonBg3 },
  IndentBlanklineSpaceChar = { link = 'IndentBlanklineChar' },
  IndentBlanklineSpaceCharBlankline = { link = 'IndentBlanklineChar' },

  -- nvim-dap-ui
  DebugBreakpoint = { fg = c_red },
  DebugBreakpointLine = { fg = c_red },
  DebugStopped = { fg = c_yellow },
  DebugStoppedLine = { fg = c_yellow },
  DebugLogPoint = { fg = c_blue },
  DebugLogPointLine = { fg = c_blue },

  DapUIBreakpointsCurrentLine = { bold = true, fg = c_dragonFg0 },
  DapUIBreakpointsDisabledLine = { link = 'Comment' },
  DapUIBreakpointsInfo = { fg = c_blue },
  DapUIBreakpointsPath = { link = 'Directory' },
  DapUIDecoration = { fg = c_sumiInk6 },
  DapUIFloatBorder = { link = 'FloatBorder' },
  DapUILineNumber = { fg = c_blue },
  DapUIModifiedValue = { bold = true, fg = c_blue },
  DapUIPlayPause = { fg = c_green },
  DapUIRestart = { fg = c_green },
  DapUIScope = { link = 'Special' },
  DapUISource = { fg = c_red },
  DapUIStepBack = { fg = c_blue },
  DapUIStepInto = { fg = c_blue },
  DapUIStepOut = { fg = c_blue },
  DapUIStepOver = { fg = c_blue },
  DapUIStop = { fg = c_red },
  DapUIStoppedThread = { fg = c_blue },
  DapUIThread = { fg = c_dragonFg0 },
  DapUIType = { link = 'Type' },
  DapUIUnavailable = { fg = c_dragonAsh },
  DapUIWatchesEmpty = { fg = c_red },
  DapUIWatchesError = { fg = c_red },
  DapUIWatchesValue = { fg = c_dragonFg0 },

  -- lazy.nvim
  LazyProgressTodo = { fg = c_dragonBg5 },

  -- statusline
  StatusLineGitAdded = { bg = c_dragonBg3, fg = c_green },
  StatusLineGitChanged = { bg = c_dragonBg3, fg = c_yellow },
  StatusLineGitRemoved = { bg = c_dragonBg3, fg = c_red },
  StatusLineHeader = { bg = c_dragonBg5, fg = c_dragonFg1 },
  StatusLineHeaderModified = { bg = c_red, fg = c_dragonBg1 },
}

-- Highlight group overrides {{{1
-- if vim.go.bg == 'light' then hlgroups.CursorLine = { bg = c_dragonBg0 }
--   hlgroups.FloatBorder = { bg = c_dragonBg0, fg = c_dragonBg0 }
--   hlgroups.NormalFloat = { bg = c_dragonBg0 }
--   hlgroups.DiagnosticSignWarn = { fg = c_yellow }
--   hlgroups.DiagnosticUnderlineWarn = { sp = c_yellow, undercurl =
--   true } hlgroups.DiagnosticVirtualTextWarn = { bg = c_yellow, fg
--   = c_yellow } hlgroups.DiagnosticWarn = { fg =
--   c_yellow }
--
--   hlgroups.TelescopeBorder = { bg = c_dragonBg0, fg =
--   c_dragonBg0 } hlgroups.TelescopeMatching = { fg = c_red, bold =
--   true } hlgroups.TelescopeNormal = { fg = c_dragonFg0, bg =
--   c_dragonBg0 } hlgroups.TelescopePromptBorder = { fg = c_dragonBg0, bg
--   = c_dragonBg0 } hlgroups.TelescopePromptNormal = { bg =
--   c_dragonBg0 } hlgroups.TelescopePreviewNormal = { bg = c_dragonBg2 }
--   hlgroups.TelescopePreviewBorder = { fg = c_dragonBg2, bg =
--   c_dragonBg2 }
--end

-- Set highlight groups
for hlgroup_name, hlgroup_attr in pairs(hlgroups) do
  vim.api.nvim_set_hl(0, hlgroup_name, hlgroup_attr)
end

-- vim:ts=2:sw=2:sts=2:fdm=marker:fdl=0

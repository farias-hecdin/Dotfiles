local api = vim.api

local function theme_normal()
  local conf = api.nvim_get_hl_by_name('Normal', true)
  if conf.background then
    return conf.background
  end
  return 'NONE'
end

local function hi_define()
  local bg = theme_normal()
  return {
    -- general
    TitleString = { link = 'Title' },
    TitleIcon = { link = 'Repeat' },
    SystemBorder = { link = 'FloatBorder' },
    SystemNormal = { bg = bg },
    SystemExpand = { fg = '#475164' },
    SystemCollapse = { fg = '#475164' },
    SystemCount = { link = 'Comment' },
    SystemBeacon = { bg = '#c43963' },
    -- code action
    ActionFix = { link = 'Keyword' },
    ActionPreviewNormal = { link = 'SystemNormal' },
    ActionPreviewBorder = { link = 'SystemBorder' },
    ActionPreviewTitle = { link = 'Title' },
    CodeActionNormal = { link = 'SystemNormal' },
    CodeActionBorder = { link = 'SystemBorder' },
    CodeActionText = { link = '@variable' },
    CodeActionNumber = { link = 'DiffAdd' },
    -- finder
    FinderSelection = { link = 'String' },
    FinderFName = {},
    FinderCode = { link = 'Comment' },
    FinderCount = { link = 'Constant' },
    FinderIcon = { link = 'Type' },
    FinderType = { link = '@property' },
    FinderStart = { link = 'Function' },
    --finder spinner
    FinderSpinnerTitle = { link = 'Statement' },
    FinderSpinner = { link = 'Statement' },
    FinderPreview = { link = 'Search' },
    FinderLines = { link = 'Operator' },
    FinderNormal = { link = 'SystemNormal' },
    FinderBorder = { link = 'SystemBorder' },
    FinderPreviewBorder = { link = 'SystemBorder' },
    -- definition
    DefinitionBorder = { link = 'SystemBorder' },
    DefinitionNormal = { link = 'SystemNormal' },
    DefinitionSearch = { link = 'Search' },
    -- hover
    HoverNormal = { link = 'SystemNormal' },
    HoverBorder = { link = 'SystemBorder' },
    -- rename
    RenameBorder = { link = 'SystemBorder' },
    RenameNormal = { link = 'Statement' },
    RenameMatch = { link = 'Search' },
    -- diagnostic
    DiagnosticBorder = { link = 'SystemBorder' },
    DiagnosticSource = { link = 'Comment' },
    DiagnosticNormal = { link = 'SystemNormal' },
    DiagnosticText = {},
    DiagnosticBufnr = { link = '@variable' },
    DiagnosticFname = { link = 'KeyWord' },
    DiagnosticShowNormal = { link = 'SystemNormal' },
    DiagnosticShowBorder = { link = '@property' },
    -- Call Hierachry
    CallHierarchyNormal = { link = 'SystemNormal' },
    CallHierarchyBorder = { link = 'SystemBorder' },
    CallHierarchyIcon = { link = 'TitleIcon' },
    CallHierarchyTitle = { link = 'Title' },
    -- lightbulb
    SystemLightBulb = { link = 'DiagnosticSignHint' },
    -- shadow
    SystemShadow = { link = 'FloatShadow' },
    -- Outline
    OutlineIndent = { fg = '#806d9e' },
    OutlinePreviewBorder = { link = 'SystemNormal' },
    OutlinePreviewNormal = { link = 'SystemBorder' },
    OutlineWinSeparator = { link = 'WinSeparator' },
    -- Float term
    TerminalBorder = { link = 'SystemBorder' },
    TerminalNormal = { link = 'SystemNormal' },
  }
end

local function init_highlight()
  for group, conf in pairs(hi_define()) do
    api.nvim_set_hl(0, group, vim.tbl_extend('keep', conf, { default = true }))
  end
end

return {
  init_highlight = init_highlight,
}
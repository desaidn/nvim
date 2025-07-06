-- Clear existing highlights
vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd 'syntax reset'
end

-- Set colorscheme name
vim.g.colors_name = 'dark-plus'

local hl = require('utils').hl

-- Color palette
local colors = {
  -- Syntax colors
  func = '#DCDCAA',
  type = '#4EC9B0',
  variable = '#9CDCFE',
  constant = '#4FC1FF',
  keyword = '#C586C0',
  string = '#CE9178',
  comment = '#6A9955',
  number = '#B5CEA8',
  escape = '#D7BA7D',

  -- Editor colors
  bg = '#1E1E1E',
  fg = '#D4D4D4',
  selection = '#264F78',
  inactive_selection = '#3A3D41',
  line_highlight = '#2A2D2E',

  -- UI colors
  menu_bg = '#252526',
  menu_fg = '#CCCCCC',
  border = '#6B6B6B',
  activity_badge = '#007ACC',
}

-- Base editor colors
hl('Normal', { fg = colors.fg, bg = colors.bg })
hl('Visual', { bg = colors.selection })
hl('VisualNOS', { bg = colors.inactive_selection })
hl('Cursor', { reverse = true })
hl('CursorLine', { bg = colors.line_highlight })
hl('CursorColumn', { bg = colors.line_highlight })
hl('LineNr', { fg = '#858585' })
hl('CursorLineNr', { fg = colors.fg, bold = true })
hl('SignColumn', { bg = colors.bg })
hl('Folded', { fg = '#808080', bg = '#262626' })
hl('FoldColumn', { fg = '#808080', bg = colors.bg })
hl('ColorColumn', { bg = colors.line_highlight })

-- Search and match highlighting
hl('Search', { fg = '#000000', bg = '#FFFF00' })
hl('IncSearch', { fg = '#000000', bg = '#FFFF00' })
hl('MatchParen', { fg = '#FFD700', bold = true })

-- Diff colors
hl('DiffAdd', { fg = colors.type, bg = '#1B4332' })
hl('DiffChange', { fg = colors.func, bg = '#2D2A00' })
hl('DiffDelete', { fg = '#F44747', bg = '#5A1E1E' })
hl('DiffText', { fg = colors.func, bg = '#404000', bold = true })

-- Error and warning colors
hl('ErrorMsg', { fg = '#F44747', bold = true })
hl('WarningMsg', { fg = '#FF8C00', bold = true })
hl('ModeMsg', { fg = colors.fg })
hl('MoreMsg', { fg = colors.type })
hl('Question', { fg = colors.type })

-- Treesitter highlight groups
hl('@function', { fg = colors.func })
hl('@function.builtin', { fg = colors.func })
hl('@function.call', { fg = colors.func })
hl('@function.macro', { fg = colors.func })
hl('@method', { fg = colors.func })
hl('@method.call', { fg = colors.func })
hl('@constructor', { fg = colors.func })

hl('@variable', { fg = colors.variable })
hl('@variable.builtin', { fg = colors.variable })
hl('@variable.parameter', { fg = colors.variable })
hl('@variable.member', { fg = colors.variable })
hl('@parameter', { fg = colors.variable })
hl('@property', { fg = colors.variable })
hl('@field', { fg = colors.variable })

hl('@type', { fg = colors.type })
hl('@type.builtin', { fg = colors.type })
hl('@type.definition', { fg = colors.type })
hl('@type.qualifier', { fg = colors.type })
hl('@class', { fg = colors.type })
hl('@interface', { fg = colors.type })
hl('@struct', { fg = colors.type })
hl('@enum', { fg = colors.type })
hl('@namespace', { fg = colors.type })
hl('@module', { fg = colors.type })

hl('@keyword', { fg = colors.keyword })
hl('@keyword.function', { fg = colors.keyword })
hl('@keyword.control', { fg = colors.keyword })
hl('@keyword.control.conditional', { fg = colors.keyword })
hl('@keyword.control.repeat', { fg = colors.keyword })
hl('@keyword.control.import', { fg = colors.keyword })
hl('@keyword.control.export', { fg = colors.keyword })
hl('@keyword.control.exception', { fg = colors.keyword })
hl('@keyword.operator', { fg = colors.keyword })
hl('@keyword.modifier', { fg = colors.keyword })
hl('@keyword.type', { fg = colors.keyword })
hl('@keyword.coroutine', { fg = colors.keyword })
hl('@keyword.debug', { fg = colors.keyword })
hl('@keyword.directive', { fg = colors.keyword })
hl('@keyword.directive.define', { fg = colors.keyword })

hl('@string', { fg = colors.string })
hl('@string.documentation', { fg = colors.string })
hl('@string.regexp', { fg = colors.string })
hl('@string.escape', { fg = colors.escape })
hl('@string.special', { fg = colors.escape })
hl('@string.special.symbol', { fg = colors.escape })
hl('@string.special.url', { fg = colors.escape })
hl('@string.special.path', { fg = colors.escape })

hl('@comment', { fg = colors.comment })
hl('@comment.documentation', { fg = colors.comment })
hl('@comment.error', { fg = '#F44747' })
hl('@comment.warning', { fg = '#FF8C00' })
hl('@comment.todo', { fg = '#569CD6', bold = true })
hl('@comment.note', { fg = '#569CD6', bold = true })

hl('@constant', { fg = colors.constant })
hl('@constant.builtin', { fg = colors.constant })
hl('@constant.macro', { fg = colors.constant })
hl('@boolean', { fg = colors.constant })

hl('@number', { fg = colors.number })
hl('@number.float', { fg = colors.number })

-- Operators and punctuation
hl('@operator', { fg = colors.fg })
hl('@punctuation', { fg = colors.fg })
hl('@punctuation.bracket', { fg = colors.fg })
hl('@punctuation.delimiter', { fg = colors.fg })
hl('@punctuation.special', { fg = colors.fg })

-- Labels
hl('@label', { fg = '#C8C8C8' })

-- JSX/TSX Tags
hl('@tag', { fg = colors.type })
hl('@tag.builtin', { fg = colors.type })
hl('@tag.attribute', { fg = colors.variable })
hl('@tag.delimiter', { fg = colors.fg })

-- Markdown
hl('@markup.strong', { fg = colors.fg, bold = true })
hl('@markup.italic', { fg = colors.fg, italic = true })
hl('@markup.underline', { fg = colors.fg, underline = true })
hl('@markup.strikethrough', { fg = colors.fg, strikethrough = true })
hl('@markup.heading', { fg = colors.func, bold = true })
hl('@markup.link', { fg = colors.variable, underline = true })
hl('@markup.link.url', { fg = colors.string, underline = true })
hl('@markup.list', { fg = colors.fg })
hl('@markup.list.checked', { fg = colors.type })
hl('@markup.list.unchecked', { fg = colors.comment })
hl('@markup.quote', { fg = colors.comment, italic = true })
hl('@markup.math', { fg = colors.constant })
hl('@markup.environment', { fg = colors.keyword })
hl('@markup.environment.name', { fg = colors.type })
hl('@markup.raw', { fg = colors.string })
hl('@markup.raw.block', { fg = colors.string })

-- Traditional Vim highlight groups
hl('Function', { fg = colors.func })
hl('Macro', { fg = colors.func })
hl('PreProc', { fg = colors.func })
hl('PreCondit', { fg = colors.func })
hl('Include', { fg = colors.func })
hl('Define', { fg = colors.func })

hl('Identifier', { fg = colors.variable })
hl('Variable', { fg = colors.variable })

hl('Keyword', { fg = colors.keyword })
hl('Statement', { fg = colors.keyword })
hl('Conditional', { fg = colors.keyword })
hl('Repeat', { fg = colors.keyword })
hl('Exception', { fg = colors.keyword })
hl('Operator', { fg = colors.keyword })

hl('Type', { fg = colors.type })
hl('StorageClass', { fg = colors.type })
hl('Structure', { fg = colors.type })
hl('Typedef', { fg = colors.type })

hl('String', { fg = colors.string })
hl('Character', { fg = colors.string })
hl('SpecialChar', { fg = colors.escape })
hl('Delimiter', { fg = colors.escape })

hl('Comment', { fg = colors.comment })
hl('SpecialComment', { fg = colors.comment })
hl('Todo', { fg = '#569CD6', bold = true })

hl('Constant', { fg = colors.constant })
hl('Boolean', { fg = colors.constant })
hl('Number', { fg = colors.number })
hl('Float', { fg = colors.number })

hl('Special', { fg = colors.escape })
hl('SpecialKey', { fg = colors.escape })
hl('NonText', { fg = '#3C3C3C' })
hl('Directory', { fg = colors.type })
hl('Title', { fg = colors.func, bold = true })
hl('Label', { fg = '#C8C8C8' })
hl('Tag', { fg = '#C8C8C8' })

-- LSP semantic tokens
hl('@lsp.type.function', { fg = colors.func })
hl('@lsp.type.method', { fg = colors.func })
hl('@lsp.type.macro', { fg = colors.func })

hl('@lsp.type.variable', { fg = colors.variable })
hl('@lsp.type.parameter', { fg = colors.variable })
hl('@lsp.type.property', { fg = colors.variable })
hl('@lsp.type.field', { fg = colors.variable })
hl('@lsp.type.enumMember', { fg = colors.variable })

hl('@lsp.type.keyword', { fg = colors.keyword })
hl('@lsp.type.operator', { fg = colors.keyword })

hl('@lsp.type.type', { fg = colors.type })
hl('@lsp.type.class', { fg = colors.type })
hl('@lsp.type.interface', { fg = colors.type })
hl('@lsp.type.struct', { fg = colors.type })
hl('@lsp.type.enum', { fg = colors.type })
hl('@lsp.type.namespace', { fg = colors.type })
hl('@lsp.type.typeParameter', { fg = colors.type })

hl('@lsp.type.constant', { fg = colors.constant })

-- LSP modifiers
hl('@lsp.mod.deprecated', { fg = colors.comment, strikethrough = true })

-- UI element colors
hl('Pmenu', { fg = colors.menu_fg, bg = colors.menu_bg })
hl('PmenuSel', { fg = colors.fg, bg = colors.activity_badge })
hl('PmenuSbar', { bg = colors.border })
hl('PmenuThumb', { bg = colors.fg })
hl('PmenuKind', { fg = colors.type, bg = colors.menu_bg })
hl('PmenuKindSel', { fg = colors.type, bg = colors.activity_badge })
hl('PmenuExtra', { fg = colors.comment, bg = colors.menu_bg })
hl('PmenuExtraSel', { fg = colors.comment, bg = colors.activity_badge })

-- Status line
hl('StatusLine', { fg = colors.fg, bg = colors.activity_badge })
hl('StatusLineNC', { fg = colors.comment, bg = colors.menu_bg })
hl('StatusLineTerm', { fg = colors.fg, bg = colors.activity_badge })
hl('StatusLineTermNC', { fg = colors.comment, bg = colors.menu_bg })

-- Tab line
hl('TabLine', { fg = colors.comment, bg = colors.menu_bg })
hl('TabLineFill', { bg = colors.bg })
hl('TabLineSel', { fg = colors.fg, bg = '#222222' })

-- Window separators
hl('VertSplit', { fg = colors.border, bg = colors.bg })
hl('WinSeparator', { fg = colors.border, bg = colors.bg })

-- Floating windows
hl('NormalFloat', { fg = colors.fg, bg = colors.menu_bg })
hl('FloatBorder', { fg = colors.border, bg = colors.menu_bg })
hl('FloatTitle', { fg = colors.func, bg = colors.menu_bg, bold = true })

-- Wildmenu
hl('WildMenu', { fg = colors.fg, bg = colors.activity_badge })

-- Quickfix
hl('QuickFixLine', { bg = colors.inactive_selection })
hl('qfLineNr', { fg = colors.comment })
hl('qfFileName', { fg = colors.type })

-- Diagnostics
hl('DiagnosticError', { fg = '#F44747' })
hl('DiagnosticWarn', { fg = '#FF8C00' })
hl('DiagnosticInfo', { fg = '#569CD6' })
hl('DiagnosticHint', { fg = colors.comment })
hl('DiagnosticUnderlineError', { sp = '#F44747', undercurl = true })
hl('DiagnosticUnderlineWarn', { sp = '#FF8C00', undercurl = true })
hl('DiagnosticUnderlineInfo', { sp = '#569CD6', undercurl = true })
hl('DiagnosticUnderlineHint', { sp = colors.comment, undercurl = true })

-- Git signs
hl('GitSignsAdd', { fg = colors.type })
hl('GitSignsChange', { fg = '#FFA500' })
hl('GitSignsDelete', { fg = '#F44747' })
hl('GitSignsAddLn', { bg = '#1B4332' })
hl('GitSignsChangeLn', { bg = '#2D2A00' })
hl('GitSignsDeleteLn', { bg = '#5A1E1E' })

-- Telescope
hl('TelescopeNormal', { fg = colors.fg, bg = colors.menu_bg })
hl('TelescopeBorder', { fg = colors.border, bg = colors.menu_bg })
hl('TelescopePromptNormal', { fg = colors.fg, bg = colors.menu_bg })
hl('TelescopePromptBorder', { fg = colors.border, bg = colors.menu_bg })
hl('TelescopePromptTitle', { fg = colors.func, bg = colors.menu_bg, bold = true })
hl('TelescopePreviewTitle', { fg = colors.func, bg = colors.menu_bg, bold = true })
hl('TelescopeResultsTitle', { fg = colors.func, bg = colors.menu_bg, bold = true })
hl('TelescopeSelection', { fg = colors.fg, bg = colors.inactive_selection })
hl('TelescopeMatching', { fg = colors.activity_badge, bold = true })

-- Blink.cmp specific highlight groups
hl('BlinkCmpLabel', { fg = colors.menu_fg, bg = colors.menu_bg })
hl('BlinkCmpLabelDeprecated', { fg = colors.comment, bg = colors.menu_bg, strikethrough = true })
hl('BlinkCmpLabelMatch', { fg = colors.activity_badge, bg = colors.menu_bg, bold = true })
hl('BlinkCmpLabelDescription', { fg = colors.comment, bg = colors.menu_bg })
hl('BlinkCmpLabelDetail', { fg = colors.comment, bg = colors.menu_bg })

hl('BlinkCmpDoc', { fg = colors.fg, bg = colors.menu_bg })
hl('BlinkCmpDocBorder', { fg = colors.border, bg = colors.menu_bg })
hl('BlinkCmpDocSeparator', { fg = colors.border, bg = colors.menu_bg })

hl('BlinkCmpSignatureHelp', { fg = colors.fg, bg = colors.menu_bg })
hl('BlinkCmpSignatureHelpBorder', { fg = colors.border, bg = colors.menu_bg })
hl('BlinkCmpSignatureHelpActiveParameter', { fg = colors.activity_badge, bg = colors.menu_bg, bold = true })

-- Blink.cmp kind highlights (no icons, just text colors)
hl('BlinkCmpKind', { fg = colors.type, bg = colors.menu_bg })
hl('BlinkCmpKindText', { fg = colors.fg, bg = colors.menu_bg })
hl('BlinkCmpKindMethod', { fg = colors.func, bg = colors.menu_bg })
hl('BlinkCmpKindFunction', { fg = colors.func, bg = colors.menu_bg })
hl('BlinkCmpKindConstructor', { fg = colors.func, bg = colors.menu_bg })
hl('BlinkCmpKindField', { fg = colors.variable, bg = colors.menu_bg })
hl('BlinkCmpKindVariable', { fg = colors.variable, bg = colors.menu_bg })
hl('BlinkCmpKindClass', { fg = colors.type, bg = colors.menu_bg })
hl('BlinkCmpKindInterface', { fg = colors.type, bg = colors.menu_bg })
hl('BlinkCmpKindModule', { fg = colors.type, bg = colors.menu_bg })
hl('BlinkCmpKindProperty', { fg = colors.variable, bg = colors.menu_bg })
hl('BlinkCmpKindUnit', { fg = colors.number, bg = colors.menu_bg })
hl('BlinkCmpKindValue', { fg = colors.number, bg = colors.menu_bg })
hl('BlinkCmpKindEnum', { fg = colors.type, bg = colors.menu_bg })
hl('BlinkCmpKindKeyword', { fg = colors.keyword, bg = colors.menu_bg })
hl('BlinkCmpKindSnippet', { fg = colors.string, bg = colors.menu_bg })
hl('BlinkCmpKindColor', { fg = colors.string, bg = colors.menu_bg })
hl('BlinkCmpKindFile', { fg = colors.fg, bg = colors.menu_bg })
hl('BlinkCmpKindReference', { fg = colors.variable, bg = colors.menu_bg })
hl('BlinkCmpKindFolder', { fg = colors.type, bg = colors.menu_bg })
hl('BlinkCmpKindEnumMember', { fg = colors.constant, bg = colors.menu_bg })
hl('BlinkCmpKindConstant', { fg = colors.constant, bg = colors.menu_bg })
hl('BlinkCmpKindStruct', { fg = colors.type, bg = colors.menu_bg })
hl('BlinkCmpKindEvent', { fg = colors.keyword, bg = colors.menu_bg })
hl('BlinkCmpKindOperator', { fg = colors.keyword, bg = colors.menu_bg })
hl('BlinkCmpKindTypeParameter', { fg = colors.type, bg = colors.menu_bg })

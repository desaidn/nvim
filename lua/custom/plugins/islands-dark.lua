-- JetBrains Islands Dark colorscheme for Neovim
-- Ported from JetBrains IDEs Islands Dark theme

return {
  'islands-dark',
  name = 'islands-dark',
  virtual = true,
  lazy = false,
  priority = 1000,
  config = function()
    -- Islands Dark color palette
    local colors = {
      -- Base colors
      bg = '#191a1c',
      bg_dark = '#131415',
      bg_light = '#25272a',
      bg_float = '#2b2d30',
      bg_visual = '#2d4f67',
      bg_selection = '#214283',

      -- Foreground colors
      fg = '#bcbec4',
      fg_dark = '#7a7e85',
      fg_dim = '#5f6368',

      -- Syntax colors
      keyword = '#cf8e6d',
      string = '#6aab73',
      number = '#2aacb8',
      func = '#56a8f5',
      comment = '#7a7e85',
      type = '#c77dbb',
      constant = '#6897bb',
      variable = '#bcbec4',
      parameter = '#bcbec4',
      property = '#c77dbb',
      operator = '#bcbec4',
      punctuation = '#bcbec4',

      -- UI colors
      border = '#393b40',
      cursor_line = '#26282e',
      line_nr = '#4e5157',
      line_nr_cur = '#a1a3ab',
      search = '#32593d',
      inc_search = '#61a36a',
      match_paren = '#3b514d',

      -- Diff colors
      diff_add = '#294436',
      diff_add_fg = '#6aab73',
      diff_change = '#303c47',
      diff_change_fg = '#6897bb',
      diff_delete = '#3f2d2d',
      diff_delete_fg = '#f75464',

      -- Diagnostic colors
      error = '#f75464',
      warning = '#e9a33e',
      info = '#56a8f5',
      hint = '#6aab73',

      -- Git colors
      git_add = '#6aab73',
      git_change = '#e9a33e',
      git_delete = '#f75464',

      -- Special
      none = 'NONE',
    }

    local function set_hl(group, opts)
      vim.api.nvim_set_hl(0, group, opts)
    end

    local function load_theme()
      vim.cmd 'hi clear'
      if vim.fn.exists 'syntax_on' then
        vim.cmd 'syntax reset'
      end
      vim.o.termguicolors = true
      vim.g.colors_name = 'islands-dark'

      -- Editor
      set_hl('Normal', { fg = colors.fg, bg = colors.none })
      set_hl('NormalNC', { fg = colors.fg, bg = colors.none })
      set_hl('NormalFloat', { fg = colors.fg, bg = colors.bg_float })
      set_hl('FloatBorder', { fg = colors.border, bg = colors.bg_float })
      set_hl('FloatTitle', { fg = colors.fg, bg = colors.bg_float, bold = true })
      set_hl('Cursor', { fg = colors.bg, bg = colors.fg })
      set_hl('CursorLine', { bg = colors.none })
      set_hl('CursorColumn', { bg = colors.cursor_line })
      set_hl('ColorColumn', { bg = colors.bg_light })
      set_hl('LineNr', { fg = colors.line_nr })
      set_hl('CursorLineNr', { fg = colors.line_nr_cur, bold = true })
      set_hl('SignColumn', { fg = colors.fg, bg = colors.none })
      set_hl('VertSplit', { fg = colors.border })
      set_hl('WinSeparator', { fg = colors.border })
      set_hl('Folded', { fg = colors.comment, bg = colors.bg_light })
      set_hl('FoldColumn', { fg = colors.comment })
      set_hl('EndOfBuffer', { fg = colors.bg })
      set_hl('NonText', { fg = colors.fg_dim })
      set_hl('SpecialKey', { fg = colors.fg_dim })
      set_hl('Conceal', { fg = colors.fg_dim })
      set_hl('MatchParen', { bg = colors.match_paren, bold = true })

      -- Popup menu
      set_hl('Pmenu', { fg = colors.fg, bg = colors.bg_float })
      set_hl('PmenuSel', { fg = colors.fg, bg = colors.bg_selection })
      set_hl('PmenuSbar', { bg = colors.bg_light })
      set_hl('PmenuThumb', { bg = colors.border })

      -- Search
      set_hl('Search', { fg = colors.fg, bg = colors.search })
      set_hl('IncSearch', { fg = colors.bg, bg = colors.inc_search })
      set_hl('CurSearch', { fg = colors.bg, bg = colors.inc_search })
      set_hl('Substitute', { fg = colors.bg, bg = colors.warning })

      -- Visual
      set_hl('Visual', { bg = colors.bg_visual })
      set_hl('VisualNOS', { bg = colors.bg_visual })

      -- Messages
      set_hl('ModeMsg', { fg = colors.fg, bold = true })
      set_hl('MsgArea', { fg = colors.fg })
      set_hl('MoreMsg', { fg = colors.info })
      set_hl('WarningMsg', { fg = colors.warning })
      set_hl('ErrorMsg', { fg = colors.error })
      set_hl('Question', { fg = colors.info })

      -- Tabs
      set_hl('TabLine', { fg = colors.comment, bg = colors.bg_dark })
      set_hl('TabLineFill', { bg = colors.bg_dark })
      set_hl('TabLineSel', { fg = colors.fg, bg = colors.bg })

      -- Status line
      set_hl('StatusLine', { fg = colors.fg, bg = colors.bg_dark })
      set_hl('StatusLineNC', { fg = colors.comment, bg = colors.bg_dark })
      set_hl('WinBar', { fg = colors.fg, bg = colors.none })
      set_hl('WinBarNC', { fg = colors.comment, bg = colors.none })

      -- Syntax highlighting
      set_hl('Comment', { fg = colors.comment, italic = true })
      set_hl('Constant', { fg = colors.constant })
      set_hl('String', { fg = colors.string })
      set_hl('Character', { fg = colors.string })
      set_hl('Number', { fg = colors.number })
      set_hl('Boolean', { fg = colors.keyword })
      set_hl('Float', { fg = colors.number })
      set_hl('Identifier', { fg = colors.variable })
      set_hl('Function', { fg = colors.func })
      set_hl('Statement', { fg = colors.keyword })
      set_hl('Conditional', { fg = colors.keyword })
      set_hl('Repeat', { fg = colors.keyword })
      set_hl('Label', { fg = colors.keyword })
      set_hl('Operator', { fg = colors.operator })
      set_hl('Keyword', { fg = colors.keyword })
      set_hl('Exception', { fg = colors.keyword })
      set_hl('PreProc', { fg = colors.keyword })
      set_hl('Include', { fg = colors.keyword })
      set_hl('Define', { fg = colors.keyword })
      set_hl('Macro', { fg = colors.constant })
      set_hl('PreCondit', { fg = colors.keyword })
      set_hl('Type', { fg = colors.type })
      set_hl('StorageClass', { fg = colors.keyword })
      set_hl('Structure', { fg = colors.type })
      set_hl('Typedef', { fg = colors.type })
      set_hl('Special', { fg = colors.constant })
      set_hl('SpecialChar', { fg = colors.constant })
      set_hl('Tag', { fg = colors.keyword })
      set_hl('Delimiter', { fg = colors.punctuation })
      set_hl('SpecialComment', { fg = colors.comment })
      set_hl('Debug', { fg = colors.warning })
      set_hl('Underlined', { fg = colors.info, underline = true })
      set_hl('Ignore', { fg = colors.fg_dim })
      set_hl('Error', { fg = colors.error })
      set_hl('Todo', { fg = colors.bg, bg = colors.warning, bold = true })

      -- Diff
      set_hl('DiffAdd', { fg = colors.diff_add_fg, bg = colors.diff_add })
      set_hl('DiffChange', { fg = colors.diff_change_fg, bg = colors.diff_change })
      set_hl('DiffDelete', { fg = colors.diff_delete_fg, bg = colors.diff_delete })
      set_hl('DiffText', { fg = colors.fg, bg = colors.bg_selection })
      set_hl('diffAdded', { fg = colors.diff_add_fg })
      set_hl('diffRemoved', { fg = colors.diff_delete_fg })
      set_hl('diffChanged', { fg = colors.diff_change_fg })

      -- Spell
      set_hl('SpellBad', { sp = colors.error, undercurl = true })
      set_hl('SpellCap', { sp = colors.warning, undercurl = true })
      set_hl('SpellLocal', { sp = colors.info, undercurl = true })
      set_hl('SpellRare', { sp = colors.hint, undercurl = true })

      -- Diagnostics
      set_hl('DiagnosticError', { fg = colors.error })
      set_hl('DiagnosticWarn', { fg = colors.warning })
      set_hl('DiagnosticInfo', { fg = colors.info })
      set_hl('DiagnosticHint', { fg = colors.hint })
      set_hl('DiagnosticUnderlineError', { sp = colors.error, undercurl = true })
      set_hl('DiagnosticUnderlineWarn', { sp = colors.warning, undercurl = true })
      set_hl('DiagnosticUnderlineInfo', { sp = colors.info, undercurl = true })
      set_hl('DiagnosticUnderlineHint', { sp = colors.hint, undercurl = true })
      set_hl('DiagnosticVirtualTextError', { fg = colors.error, bg = colors.diff_delete })
      set_hl('DiagnosticVirtualTextWarn', { fg = colors.warning, bg = colors.bg_light })
      set_hl('DiagnosticVirtualTextInfo', { fg = colors.info, bg = colors.diff_change })
      set_hl('DiagnosticVirtualTextHint', { fg = colors.hint, bg = colors.diff_add })
      set_hl('DiagnosticSignError', { fg = colors.error })
      set_hl('DiagnosticSignWarn', { fg = colors.warning })
      set_hl('DiagnosticSignInfo', { fg = colors.info })
      set_hl('DiagnosticSignHint', { fg = colors.hint })

      -- LSP
      set_hl('LspReferenceText', { bg = colors.bg_light })
      set_hl('LspReferenceRead', { bg = colors.bg_light })
      set_hl('LspReferenceWrite', { bg = colors.bg_light })
      set_hl('LspSignatureActiveParameter', { fg = colors.warning, bold = true })
      set_hl('LspCodeLens', { fg = colors.comment })
      set_hl('LspInlayHint', { fg = colors.comment, bg = colors.bg_light })

      -- Treesitter
      set_hl('@variable', { fg = colors.variable })
      set_hl('@variable.builtin', { fg = colors.keyword })
      set_hl('@variable.parameter', { fg = colors.parameter })
      set_hl('@variable.member', { fg = colors.property })
      set_hl('@constant', { fg = colors.constant })
      set_hl('@constant.builtin', { fg = colors.constant })
      set_hl('@constant.macro', { fg = colors.constant })
      set_hl('@module', { fg = colors.fg })
      set_hl('@label', { fg = colors.keyword })
      set_hl('@string', { fg = colors.string })
      set_hl('@string.documentation', { fg = colors.string })
      set_hl('@string.regexp', { fg = colors.constant })
      set_hl('@string.escape', { fg = colors.constant })
      set_hl('@string.special', { fg = colors.constant })
      set_hl('@character', { fg = colors.string })
      set_hl('@character.special', { fg = colors.constant })
      set_hl('@boolean', { fg = colors.keyword })
      set_hl('@number', { fg = colors.number })
      set_hl('@number.float', { fg = colors.number })
      set_hl('@type', { fg = colors.type })
      set_hl('@type.builtin', { fg = colors.type })
      set_hl('@type.definition', { fg = colors.type })
      set_hl('@type.qualifier', { fg = colors.keyword })
      set_hl('@attribute', { fg = colors.constant })
      set_hl('@property', { fg = colors.property })
      set_hl('@function', { fg = colors.func })
      set_hl('@function.builtin', { fg = colors.func })
      set_hl('@function.macro', { fg = colors.func })
      set_hl('@function.method', { fg = colors.func })
      set_hl('@constructor', { fg = colors.type })
      set_hl('@operator', { fg = colors.operator })
      set_hl('@keyword', { fg = colors.keyword })
      set_hl('@keyword.coroutine', { fg = colors.keyword })
      set_hl('@keyword.function', { fg = colors.keyword })
      set_hl('@keyword.operator', { fg = colors.keyword })
      set_hl('@keyword.import', { fg = colors.keyword })
      set_hl('@keyword.storage', { fg = colors.keyword })
      set_hl('@keyword.repeat', { fg = colors.keyword })
      set_hl('@keyword.return', { fg = colors.keyword })
      set_hl('@keyword.debug', { fg = colors.warning })
      set_hl('@keyword.exception', { fg = colors.keyword })
      set_hl('@keyword.conditional', { fg = colors.keyword })
      set_hl('@keyword.directive', { fg = colors.keyword })
      set_hl('@keyword.directive.define', { fg = colors.keyword })
      set_hl('@punctuation.delimiter', { fg = colors.punctuation })
      set_hl('@punctuation.bracket', { fg = colors.punctuation })
      set_hl('@punctuation.special', { fg = colors.constant })
      set_hl('@comment', { fg = colors.comment, italic = true })
      set_hl('@comment.documentation', { fg = colors.comment })
      set_hl('@comment.error', { fg = colors.error })
      set_hl('@comment.warning', { fg = colors.warning })
      set_hl('@comment.todo', { fg = colors.bg, bg = colors.warning })
      set_hl('@comment.note', { fg = colors.bg, bg = colors.info })
      set_hl('@markup.strong', { bold = true })
      set_hl('@markup.italic', { italic = true })
      set_hl('@markup.strikethrough', { strikethrough = true })
      set_hl('@markup.underline', { underline = true })
      set_hl('@markup.heading', { fg = colors.func, bold = true })
      set_hl('@markup.quote', { fg = colors.comment, italic = true })
      set_hl('@markup.math', { fg = colors.number })
      set_hl('@markup.environment', { fg = colors.keyword })
      set_hl('@markup.link', { fg = colors.info })
      set_hl('@markup.link.label', { fg = colors.info })
      set_hl('@markup.link.url', { fg = colors.info, underline = true })
      set_hl('@markup.raw', { fg = colors.string })
      set_hl('@markup.list', { fg = colors.keyword })
      set_hl('@tag', { fg = colors.keyword })
      set_hl('@tag.attribute', { fg = colors.constant })
      set_hl('@tag.delimiter', { fg = colors.punctuation })

      -- GitSigns
      set_hl('GitSignsAdd', { fg = colors.git_add })
      set_hl('GitSignsChange', { fg = colors.git_change })
      set_hl('GitSignsDelete', { fg = colors.git_delete })
      set_hl('GitSignsAddNr', { fg = colors.git_add })
      set_hl('GitSignsChangeNr', { fg = colors.git_change })
      set_hl('GitSignsDeleteNr', { fg = colors.git_delete })
      set_hl('GitSignsAddLn', { bg = colors.diff_add })
      set_hl('GitSignsChangeLn', { bg = colors.diff_change })
      set_hl('GitSignsDeleteLn', { bg = colors.diff_delete })

      -- Telescope
      set_hl('TelescopeNormal', { fg = colors.fg, bg = colors.bg_float })
      set_hl('TelescopeBorder', { fg = colors.border, bg = colors.bg_float })
      set_hl('TelescopePromptNormal', { fg = colors.fg, bg = colors.bg_float })
      set_hl('TelescopePromptBorder', { fg = colors.border, bg = colors.bg_float })
      set_hl('TelescopePromptTitle', { fg = colors.fg, bg = colors.bg_float })
      set_hl('TelescopePreviewTitle', { fg = colors.fg, bg = colors.bg_float })
      set_hl('TelescopeResultsTitle', { fg = colors.fg, bg = colors.bg_float })
      set_hl('TelescopeSelection', { fg = colors.fg, bg = colors.bg_selection })
      set_hl('TelescopeSelectionCaret', { fg = colors.keyword, bg = colors.bg_selection })
      set_hl('TelescopeMatching', { fg = colors.warning, bold = true })

      -- Which-key
      set_hl('WhichKey', { fg = colors.func })
      set_hl('WhichKeyGroup', { fg = colors.keyword })
      set_hl('WhichKeyDesc', { fg = colors.fg })
      set_hl('WhichKeySeperator', { fg = colors.comment })
      set_hl('WhichKeyFloat', { bg = colors.bg_float })

      -- Neo-tree
      set_hl('NeoTreeNormal', { fg = colors.fg, bg = colors.none })
      set_hl('NeoTreeNormalNC', { fg = colors.fg, bg = colors.none })
      set_hl('NeoTreeDirectoryName', { fg = colors.fg })
      set_hl('NeoTreeDirectoryIcon', { fg = colors.info })
      set_hl('NeoTreeRootName', { fg = colors.keyword, bold = true })
      set_hl('NeoTreeGitAdded', { fg = colors.git_add })
      set_hl('NeoTreeGitConflict', { fg = colors.error })
      set_hl('NeoTreeGitDeleted', { fg = colors.git_delete })
      set_hl('NeoTreeGitModified', { fg = colors.git_change })
      set_hl('NeoTreeGitUntracked', { fg = colors.hint })
      set_hl('NeoTreeIndentMarker', { fg = colors.border })

      -- Indent-blankline
      set_hl('IblIndent', { fg = colors.bg_light })
      set_hl('IblScope', { fg = colors.border })

      -- Trouble
      set_hl('TroubleNormal', { fg = colors.fg, bg = colors.none })
      set_hl('TroubleText', { fg = colors.fg })
      set_hl('TroubleCount', { fg = colors.keyword, bg = colors.bg_light })

      -- Mini.statusline
      set_hl('MiniStatuslineModeNormal', { fg = colors.bg, bg = colors.func, bold = true })
      set_hl('MiniStatuslineModeInsert', { fg = colors.bg, bg = colors.keyword, bold = true })
      set_hl('MiniStatuslineModeVisual', { fg = colors.bg, bg = colors.type, bold = true })
      set_hl('MiniStatuslineModeReplace', { fg = colors.bg, bg = colors.error, bold = true })
      set_hl('MiniStatuslineModeCommand', { fg = colors.bg, bg = colors.string, bold = true })
      set_hl('MiniStatuslineModeOther', { fg = colors.bg, bg = colors.hint, bold = true })
      set_hl('MiniStatuslineDevinfo', { fg = colors.fg, bg = colors.bg_light })
      set_hl('MiniStatuslineFilename', { fg = colors.fg, bg = colors.bg_dark })
      set_hl('MiniStatuslineFileinfo', { fg = colors.fg, bg = colors.bg_light })
      set_hl('MiniStatuslineInactive', { fg = colors.comment, bg = colors.bg_dark })

      -- Lazy.nvim
      set_hl('LazyNormal', { fg = colors.fg, bg = colors.bg_float })
      set_hl('LazyButton', { fg = colors.fg, bg = colors.bg_light })
      set_hl('LazyButtonActive', { fg = colors.bg, bg = colors.func })
      set_hl('LazyH1', { fg = colors.bg, bg = colors.func, bold = true })
      set_hl('LazySpecial', { fg = colors.keyword })

      -- Mason
      set_hl('MasonNormal', { fg = colors.fg, bg = colors.bg_float })
      set_hl('MasonHeader', { fg = colors.bg, bg = colors.func, bold = true })

      -- Directory
      set_hl('Directory', { fg = colors.info })

      -- Title
      set_hl('Title', { fg = colors.func, bold = true })

      -- Treesitter context
      set_hl('TreesitterContext', { bg = colors.bg_light })
      set_hl('TreesitterContextLineNumber', { fg = colors.line_nr_cur, bg = colors.bg_light })
    end

    -- Create colorscheme command
    vim.api.nvim_create_user_command('IslandsDark', load_theme, {})

    -- Auto-load on startup
    load_theme()
  end,
}

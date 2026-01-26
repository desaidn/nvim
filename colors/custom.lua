vim.cmd.highlight 'clear'
vim.g.colors_name = 'custom'

-- Load default colorscheme as base
vim.cmd.runtime 'colors/default.lua'

-- Transparent backgrounds
local transparent_groups = {
  'Normal',
  'NormalNC',
  'SignColumn',
  'EndOfBuffer',
  'WinBar',
  'WinBarNC',
  'CursorLine',
  'CursorColumn',
  'ColorColumn',
  'Folded',
}

for _, group in ipairs(transparent_groups) do
  local hl = vim.api.nvim_get_hl(0, { name = group })
  vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', hl, { bg = 'NONE' }))
end

-- Float backgrounds
local float_groups = {
  'NormalFloat',
  'FloatBorder',
  'Pmenu',
  'PmenuSbar',
  'TelescopeNormal',
  'TelescopeBorder',
  'WhichKeyFloat',
}

for _, group in ipairs(float_groups) do
  local hl = vim.api.nvim_get_hl(0, { name = group })
  vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', hl, { bg = '#2a2e38' }))
end

-- Peach accent color
local peach_groups = {
  'Function',
  'Special',
  'Changed',
  'MoreMsg',
  'Question',
  'Directory',
  'QuickFixLine',
  'DiagnosticInfo',
}

for _, group in ipairs(peach_groups) do
  local hl = vim.api.nvim_get_hl(0, { name = group })
  vim.api.nvim_set_hl(0, group, vim.tbl_extend('force', hl, { fg = '#ffb86c' }))
end

-- Diff colors
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#1e3d2a' })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#3d1e1e' })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#1e2a3d' })
vim.api.nvim_set_hl(0, 'DiffText', { bg = '#2d3a4d' })

-- Statusline background (matches float windows)
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#2a2e38' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#2a2e38' })

-- Mini statusline mode colors
vim.api.nvim_set_hl(0, 'MiniStatuslineModeNormal', { fg = '#1e1e2e', bg = '#A6DBFF', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeInsert', { fg = '#1e1e2e', bg = '#ffb86c', bold = true })
vim.api.nvim_set_hl(0, 'MiniStatuslineModeCommand', { fg = '#1e1e2e', bg = '#b4f6c0', bold = true })

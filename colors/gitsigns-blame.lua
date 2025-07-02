-- Git blame line styling - independent of main colorscheme
-- This file provides enhanced styling for git blame lines that is more
-- pronounced while still maintaining a subtle background appearance

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Git blame line - more pronounced but subtle
hl('GitSignsCurrentLineBlame', {
  fg = '#8B8B8B', -- lighter gray for more visibility than default
  -- No italic styling as requested
  -- Optional: uncomment for subtle background highlighting
  -- bg = '#1A1A1A', -- slightly darker than main background
})


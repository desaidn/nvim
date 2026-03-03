-- Lua Language Server configuration
-- Special handling for Neovim config development
--
-- When editing Neovim config files, this configures lua_ls to understand
-- the vim.* API, Neovim runtime, and plugin APIs.
--
-- See: https://luals.github.io/wiki/settings/

return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      -- Uncomment to ignore noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

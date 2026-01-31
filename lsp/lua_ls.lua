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
  on_init = function(client)
    -- If the workspace has a .luarc.json, respect it and don't override
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
    end

    -- For Neovim config editing, set up runtime and workspace libraries
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = false,
        -- Load Neovim runtime files for vim.* API completion
        library = vim.api.nvim_get_runtime_file('', true),
      },
    })
  end,
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

-- JSON Language Server configuration
-- Provides validation, completion, and formatting for JSON files
--
-- Supports JSON Schema for validation of common config files
-- See: https://github.com/microsoft/vscode-json-languageservice

return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git' },
  init_options = {
    provideFormatter = true,
  },
}

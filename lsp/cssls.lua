-- CSS Language Server configuration
-- Provides completion, validation, and formatting for CSS/SCSS/Less
--
-- See: https://github.com/microsoft/vscode-css-languageservice

return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  root_markers = { '.git' },
  init_options = {
    provideFormatter = true,
  },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}

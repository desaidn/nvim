-- HTML Language Server configuration
-- Provides completion, validation, and formatting for HTML
--
-- See: https://github.com/microsoft/vscode-html-languageservice

return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html', 'templ' },
  root_markers = { '.git' },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
  },
}

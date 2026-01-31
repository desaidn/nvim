-- TypeScript Language Server configuration
-- Handles JavaScript, TypeScript, JSX, and TSX files
--
-- Note: For larger projects, consider typescript-tools.nvim which uses
-- TypeScript's native tsserver directly for better performance.
-- See: https://github.com/pmizio/typescript-tools.nvim

return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  init_options = {
    hostInfo = 'neovim',
  },
}

-- Haskell Language Server configuration
-- Provides IDE features for Haskell development
--
-- See: https://haskell-language-server.readthedocs.io/

return {
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  filetypes = { 'haskell', 'lhaskell' },
  root_markers = { 'hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml', '.git' },
}

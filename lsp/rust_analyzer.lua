-- Rust Analyzer configuration
-- Provides IDE features for Rust development
--
-- See: https://rust-analyzer.github.io/manual.html#configuration

return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
  settings = {
    ['rust-analyzer'] = {
      -- Enable all features by default for better completions
      cargo = {
        allFeatures = true,
      },
      -- Enable clippy on save for additional lints
      check = {
        command = 'clippy',
      },
    },
  },
}

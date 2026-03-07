-- Kotlin Language Server configuration
-- Provides IDE features for Kotlin development
--
-- See: https://github.com/niclaslindstedt/kotlin-lsp

return {
  cmd = { 'kotlin-lsp' },
  filetypes = { 'kotlin' },
  root_markers = { 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts', 'pom.xml', '.git' },
}

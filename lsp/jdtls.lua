-- Eclipse JDT Language Server configuration
-- Provides IDE features for Java development
--
-- See: https://github.com/eclipse-jdtls/eclipse.jdt.ls

return {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  root_markers = { 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', 'settings.gradle.kts', '.git' },
  settings = {
    java = {
      format = { enabled = false },
    },
  },
  init_options = {
    provideFormatter = false,
  },
}

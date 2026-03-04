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

-- YAML Language Server configuration
-- Provides validation, completion, and formatting for YAML files
--
-- Supports YAML Schema for validation of common config files
-- See: https://github.com/redhat-developer/yaml-language-server

return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
  settings = {
    yaml = {
      keyOrdering = false, -- Don't enforce key ordering
    },
  },
}

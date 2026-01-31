-- ty (Astral.sh Python type checker) configuration
-- Fast Python type checker from the creators of ruff
--
-- See: https://github.com/astral-sh/ty

return {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
}

-- Debug script to diagnose ESLint duplicate diagnostics
-- Run with: :luafile debug-lint.lua

local function header(text)
  print('\n' .. string.rep('=', 60))
  print('  ' .. text)
  print(string.rep('=', 60))
end

header 'ESLint Diagnostic Debug Information'

-- 1. Check for available ESLint executables
header '1. Available ESLint Executables'
local executables = {
  './node_modules/.bin/eslint_d',
  'eslint_d',
  './node_modules/.bin/eslint',
  'eslint',
}

for _, cmd in ipairs(executables) do
  local available = vim.fn.executable(cmd) == 1
  print(string.format('  %-35s %s', cmd, available and '✓ Available' or '✗ Not found'))
end

-- 2. Check nvim-lint configuration
header '2. nvim-lint Configuration'
local lint_ok, lint = pcall(require, 'lint')
if lint_ok then
  print '  Linters by filetype:'
  for ft, linters in pairs(lint.linters_by_ft) do
    print(string.format('    %-20s %s', ft, table.concat(linters, ', ')))
  end

  -- Check if eslint_d is configured
  if lint.linters.eslint_d then
    print('\n  eslint_d command: ' .. (lint.linters.eslint_d.cmd or 'not set'))
  end
else
  print '  ✗ nvim-lint not loaded'
end

-- 3. Check active LSP clients
header '3. Active LSP Clients'
local clients = vim.lsp.get_clients()
if #clients == 0 then
  print '  No active LSP clients'
else
  for _, client in ipairs(clients) do
    print(string.format('  %s (id: %d)', client.name, client.id))

    -- Check if ts_ls has custom diagnostic handler
    if client.name == 'ts_ls' and client.handlers then
      local has_handler = client.handlers['textDocument/publishDiagnostics'] ~= nil
      print(string.format('    Custom diagnostic handler: %s', has_handler and '✓ Yes' or '✗ No'))
    end
  end
end

-- 4. Check current buffer diagnostics
header '4. Current Buffer Diagnostics'
local diagnostics = vim.diagnostic.get(0)
if #diagnostics == 0 then
  print '  No diagnostics in current buffer'
else
  -- Group diagnostics by source
  local by_source = {}
  for _, diag in ipairs(diagnostics) do
    local source = diag.source or 'unknown'
    by_source[source] = by_source[source] or {}
    table.insert(by_source[source], diag)
  end

  print(string.format('  Total diagnostics: %d', #diagnostics))
  print '\n  Grouped by source:'
  for source, diags in pairs(by_source) do
    print(string.format('    %-20s %d diagnostic(s)', source, #diags))
    -- Show first diagnostic as example
    if diags[1] then
      local first = diags[1]
      local severity = ({ 'ERROR', 'WARN', 'INFO', 'HINT' })[first.severity] or 'UNKNOWN'
      print(string.format('      Example: [%s] %s', severity, first.message:sub(1, 60)))
    end
  end

  -- Check for duplicate messages
  print '\n  Checking for duplicates:'
  local seen = {}
  local duplicates = 0
  for _, diag in ipairs(diagnostics) do
    local key = string.format('%d:%d:%s', diag.lnum, diag.col, diag.message)
    if seen[key] then
      duplicates = duplicates + 1
      print(string.format('    ⚠ Duplicate at line %d: %s', diag.lnum + 1, diag.message:sub(1, 50)))
    else
      seen[key] = true
    end
  end

  if duplicates == 0 then
    print '    ✓ No duplicates found'
  else
    print(string.format('    ✗ Found %d duplicate(s)', duplicates))
  end
end

-- 5. Summary and recommendations
header 'Summary'
print '  Run this script in a TypeScript/JavaScript file with ESLint errors'
print '  to see diagnostic sources and check for duplicates.'
print '\n  If you see duplicates:'
print '    1. Check that ESLINT_FALLBACK_ENABLED = false in lint.lua'
print '    2. Restart Neovim to apply configuration changes'
print '    3. Verify ts_ls has custom diagnostic handler (see section 3)'
print '\nPress :messages to see full output if truncated\n'

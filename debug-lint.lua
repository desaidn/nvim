-- Debug script to check linting configuration
-- Run this in Neovim with: :luafile debug-lint.lua

print("\n=== ESLint/Linting Debug Information ===\n")

-- 1. Check which eslint executables are available
print("1. Available ESLint executables:")
local eslint_paths = {
  "./node_modules/.bin/eslint_d",
  "eslint_d",
  "./node_modules/.bin/eslint",
  "eslint",
}

for _, cmd in ipairs(eslint_paths) do
  if vim.fn.executable(cmd) == 1 then
    print("  ✓ " .. cmd .. " (found)")
  else
    print("  ✗ " .. cmd .. " (not found)")
  end
end

-- 2. Check nvim-lint configuration
print("\n2. nvim-lint configuration:")
local ok, lint = pcall(require, 'lint')
if ok then
  print("  nvim-lint is loaded: YES")
  print("\n  Linters by filetype:")
  for ft, linters in pairs(lint.linters_by_ft) do
    print(string.format("    %s: [%s]", ft, table.concat(linters, ", ")))
  end
else
  print("  nvim-lint is loaded: NO")
end

-- 3. Check active LSP clients
print("\n3. Active LSP clients in current buffer:")
local clients = vim.lsp.get_clients({ bufnr = 0 })
if #clients == 0 then
  print("  No LSP clients attached")
else
  for _, client in ipairs(clients) do
    print(string.format("  - %s (id: %d)", client.name, client.id))

    -- Check if client has custom diagnostic handler
    if client.handlers and client.handlers['textDocument/publishDiagnostics'] then
      print("    Has custom publishDiagnostics handler: YES")
    end
  end
end

-- 4. Check current buffer diagnostics
print("\n4. Current buffer diagnostics:")
local diagnostics = vim.diagnostic.get(0)
print(string.format("  Total diagnostics: %d", #diagnostics))

-- Group diagnostics by source
local by_source = {}
for _, diag in ipairs(diagnostics) do
  local source = diag.source or "unknown"
  by_source[source] = (by_source[source] or 0) + 1
end

if next(by_source) then
  print("  Diagnostics by source:")
  for source, count in pairs(by_source) do
    print(string.format("    %s: %d", source, count))
  end
else
  print("  No diagnostics in current buffer")
end

-- 5. Show sample diagnostics (first 3)
if #diagnostics > 0 then
  print("\n5. Sample diagnostics (first 3):")
  for i = 1, math.min(3, #diagnostics) do
    local diag = diagnostics[i]
    print(string.format(
      "  [%d] Line %d: %s (source: %s)",
      i,
      diag.lnum + 1,
      diag.message:sub(1, 60),
      diag.source or "unknown"
    ))
  end
end

print("\n=== End Debug Information ===\n")

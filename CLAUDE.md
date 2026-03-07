# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Overview

This is a Neovim configuration based on kickstart.nvim, providing a well-documented starting point for Neovim customization. The configuration follows a single-file approach with modular plugin loading.

## Core Architecture

### File Structure

- `init.lua` - Main configuration file containing all core settings, keymaps, and plugin configurations
- `lua/custom/plugins/init.lua` - Entry point for custom plugin additions (currently empty)
- `lua/kickstart/plugins/` - Modular plugins (all currently enabled via require in init.lua):
  - `gitsigns.lua` - Git signs, blame, and hunk navigation keymaps
  - `autopairs.lua` - Auto-close brackets, quotes, etc.
  - `debug.lua` - DAP debugger setup (Go, Python)
  - `lint.lua` - nvim-lint with eslint_d, ruff, markdownlint
  - `neo-tree.lua` - File explorer (right-side, text-based icons)
- `lazy-lock.json` - Plugin version lockfile

### Plugin Management

Uses lazy.nvim as the plugin manager. Core plugins include:

- **LSP**: nvim-lspconfig with Mason for auto-installation, native Neovim 0.11+ LSP config (`lsp/*.lua`)
- **Completion**: blink.cmp with LuaSnip for snippets
- **Fuzzy Finding**: Telescope with fzf-native
- **Git Integration**: gitsigns + diffview.nvim (lazygit for GUI operations via tmux)
- **Treesitter**: Syntax highlighting, code parsing, and context (nvim-treesitter-context)
- **Formatting**: conform.nvim for auto-formatting
- **Linting**: nvim-lint with eslint_d, ruff, markdownlint
- **Debugging**: nvim-dap with Go (delve) and Python (debugpy via uv)
- **UI**: which-key, mini.nvim (statusline, surround, text objects), undotree, todo-comments

### Key Bindings Structure

- Leader key: `<Space>`
- Search operations: `<leader>s*` (files, grep, help, etc.)
- Toggle options: `<leader>t*` (inlay hints, blame)
- Git operations: `<leader>g*` (blame, diff, history), `<leader>h*` (hunks)
- LSP operations: `gr*` prefix (Neovim 0.11 defaults for rename/code action, Telescope overrides for references/definitions)
- Format: `<leader>f` (format buffer)
- Explorer: `<leader>e` (neo-tree toggle)
- Debug: `<leader>b` (breakpoint), `F1-F5/F7` (stepping, continue, DAP UI)

## Development Workflows

### Plugin Management

- `:Lazy` - View plugin status and manage installations
- `:Lazy update` - Update all plugins
- `:Mason` - Manage LSP servers, formatters, and linters
- `:checkhealth` - Diagnose configuration issues

### LSP and Language Support

Configured with multiple language servers (TypeScript, Python/ty, Rust, Go, Lua, JSON, YAML, HTML, CSS, Haskell). LSP configs live in `lsp/*.lua` using the native Neovim 0.11+ config system. To add other languages:

1. Create `lsp/<server_name>.lua` with server config (cmd, filetypes, root_markers, settings)
2. Add entry to `servers` table in init.lua (`server_name = 'mason-package-name'`)
3. Add formatters to `formatters_by_ft` in conform.nvim config if needed
4. Run `:Mason` to install required tools

### Terminal Integration

Minimal terminal integration (tmux handles primary terminal functionality):

- `<Esc><Esc>` - Exit terminal mode when needed
- `<C-h/j/k/l>` - Navigate between windows

### Git Integration

Focused on in-editor git functionality:

- **gitsigns**: In-editor git signs, blame, and hunk navigation
- `<leader>gb` - Toggle git blame line
- `<leader>h*` - Hunk operations (stage, reset, undo, preview, diff)
- `<leader>gd` - Open diffview
- `<leader>gh` - File history (diffview)
- `]c` / `[c` - Navigate between git hunks

### File Explorer

Neo-tree file explorer is enabled with right-side positioning and minimal styling:

- `<leader>e` - Toggle neo-tree (reveals current file location)
- Supports multiple sources: filesystem, buffers, git status
- Key mappings: `?` for help, `a` to add files, `d` to delete, `r` to rename
- Switch sources with `<Tab>` (filesystem → buffers → git_status)
- Configured without icons for clean, text-based interface
- Git status colors match the main colorscheme (+, ~, -, etc.)

### Customization Points

- `lua/custom/plugins/init.lua` - Add new plugins without modifying core files
- `lsp/*.lua` - Add/modify LSP server configurations
- Modify `servers` table in init.lua for enabling LSP servers
- Adjust `formatters_by_ft` in conform.nvim config for language-specific formatting
- Adjust `linters_by_ft` in lint.lua for language-specific linting

### Important Settings

- Leader key is Space (`vim.g.mapleader = ' '`)
- Auto-formatting on save enabled (can be disabled per filetype)
- Clipboard integration with system clipboard enabled
- Icons disabled - clean text-based interface without Nerd Font requirements

## Dependencies

External tools required:

- `git`, `make`, `unzip`, C compiler
- `ripgrep` (rg) for searching
- `fd-find` for file finding (optional, Telescope uses it if available)
- `tree-sitter-cli` for Treesitter parser management (`brew install tree-sitter-cli`)
- Clipboard tool (pbcopy on macOS, xclip/xsel on Linux)
- Language-specific tools (npm for TypeScript, go for Golang, etc.)

## Configuration Philosophy

This configuration prioritizes:

- **Text editing focus**: Core LSP, search, and navigation functionality
- **Minimal external dependencies**: Let tmux handle terminal/window management
- **Readability and documentation**: Single init.lua with modular LSP configs and plugin files
- **Integration with ecosystem**: Works seamlessly with tmux-based workflows

## Coding Guidelines

### Comments

Only add comments when genuinely clarifying or documenting key behavior. Aim to write clear and readable code that is self-explanatory through:

- Descriptive variable and function names
- Logical code structure and organization
- Small, focused functions with clear purposes

Avoid redundant comments that simply restate what the code does. Reserve comments for:

- Complex algorithms or business logic
- Non-obvious configuration choices
- Important architectural decisions
- External API or plugin-specific requirements

## Memory

### Configuration Verification

- Always verify that there's only one way to do something in the configuration

### Development Practices

- Always look up nvim documentation before implementing anything
- Always inline clear, concise and useful documentation in code
- Always explain choices and follow latest standards and best practices
- Prioritize reliable, cross-platform solutions over clever hacks
- The simplest solution is often the most correct and maintainable
- Never remove kickstart.nvim instructional comments or other educational comments
- Preserve multi-platform compatibility checks (e.g., Windows detection) even on a macOS-only setup

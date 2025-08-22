# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Overview

This is a Neovim configuration based on kickstart.nvim, providing a well-documented starting point for Neovim customization. The configuration follows a single-file approach with modular plugin loading.

## Core Architecture

### File Structure

- `init.lua` - Main configuration file containing all core settings, keymaps, and plugin configurations
- `lua/custom/plugins/init.lua` - Entry point for custom plugin additions (currently empty)
- `lua/kickstart/plugins/` - Optional modular plugins that can be enabled:
  - `gitsigns.lua` - Enhanced git integration with keymaps (currently enabled)
  - `autopairs.lua`, `debug.lua`, `lint.lua`, `neo-tree.lua` - Available but not enabled
- `lazy-lock.json` - Plugin version lockfile

### Plugin Management

Uses lazy.nvim as the plugin manager. Core plugins include:

- **LSP**: nvim-lspconfig with Mason for auto-installation
- **Completion**: blink.cmp with LuaSnip for snippets
- **Fuzzy Finding**: Telescope with fzf-native
- **Git Integration**: gitsigns + lazygit for GUI operations
- **Treesitter**: Syntax highlighting and code parsing
- **Formatting**: conform.nvim for auto-formatting
- **UI**: which-key, mini.nvim modules (statusline, surround, text objects)

### Key Bindings Structure

- Leader key: `<Space>`
- Search operations: `<leader>s*` (files, grep, help, etc.)
- Toggle options: `<leader>T*` (inlay hints, diagnostics)
- Git operations: `<leader>g*` (blame toggle)
- LSP operations: `gr*` prefix (rename, references, definitions)
- Diagnostics: `<leader>d*` (trouble, references, symbols)

## Development Workflows

### Plugin Management

- `:Lazy` - View plugin status and manage installations
- `:Lazy update` - Update all plugins
- `:Mason` - Manage LSP servers, formatters, and linters
- `:checkhealth` - Diagnose configuration issues

### LSP and Language Support

Configured with multiple language servers including TypeScript, Python, Rust, Go, Lua, and more. To add other languages:

1. Add server to `servers` table in init.lua (around line 941)
2. Add formatters to `formatters_by_ft` in conform.nvim config (around line 1087)
3. Run `:Mason` to install required tools

### Terminal Integration

Minimal terminal integration (tmux handles primary terminal functionality):

- `<Esc><Esc>` - Exit terminal mode when needed
- `<C-h/j/k/l>` - Navigate between windows

### Git Integration

Focused on in-editor git functionality:

- **gitsigns**: In-editor git signs, blame, and hunk navigation
- `<leader>gb` - Toggle git blame line
- `]c` / `[c` - Navigate between git hunks

Git blame line styling is configured with enhanced visibility and appears at the end of lines with improved contrast while maintaining a subtle background appearance.

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
- Uncomment kickstart plugins in init.lua (lines 1012-1016) to enable additional features
- Modify `servers` table for LSP configuration
- Adjust `formatters_by_ft` for language-specific formatting

### Important Settings

- `vim.g.have_nerd_font = false` - Set to true if using a Nerd Font
- Leader key is Space (`vim.g.mapleader = ' '`)
- Auto-formatting on save enabled (can be disabled per filetype)
- Clipboard integration with system clipboard enabled

## Dependencies

External tools required:

- `git`, `make`, `unzip`, C compiler
- `ripgrep` (rg) for searching
- `fd-find` for file finding
- Clipboard tool (xclip/xsel/win32yank)
- Language-specific tools (npm for TypeScript, go for Golang, etc.)

## Configuration Philosophy

This configuration prioritizes:

- **Text editing focus**: Core LSP, search, and navigation functionality
- **Minimal external dependencies**: Let tmux handle terminal/window management  
- **Readability and documentation**: Single-file simplicity with extensive comments
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

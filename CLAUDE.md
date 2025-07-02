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
  - `autopairs.lua`, `debug.lua`, `indent_line.lua`, `lint.lua`, `neo-tree.lua` - Available but not enabled
- `colors/dark-plus.lua` - Custom colorscheme
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
- Terminal operations: `<leader>t*` (horizontal, small, fullscreen)
- Toggle options: `<leader>T*` (inlay hints, blame line)
- Git operations: `<leader>g*` (lazygit, blame, diff)
- Git hunks: `<leader>h*` (stage, reset, preview)
- LSP operations: `gr*` prefix (rename, references, definitions)

## Development Workflows

### Plugin Management
- `:Lazy` - View plugin status and manage installations
- `:Lazy update` - Update all plugins
- `:Mason` - Manage LSP servers, formatters, and linters
- `:checkhealth` - Diagnose configuration issues

### LSP and Language Support
Currently configured for Lua development with lua_ls. To add other languages:
1. Add server to `servers` table in init.lua (around line 674)
2. Add formatters to `formatters_by_ft` in conform.nvim config (around line 770)
3. Run `:Mason` to install required tools

### Terminal Integration
Built-in terminal functionality with convenient keymaps:
- `<leader>th` - Horizontal terminal split (50% height)
- `<leader>ts` - Small horizontal terminal split (10 lines)
- `<leader>tf` - Fullscreen terminal
- `<C-h/j/k/l>` in terminal mode - Navigate between windows
- `<Esc><Esc>` - Exit terminal mode

### Git Integration
Two git systems are integrated:
- **gitsigns**: In-editor git signs and hunk operations (`<leader>h*`)
- **lazygit**: Full-featured git GUI (`<leader>gg`)

Git blame line styling is configured with enhanced visibility via a separate colors file (`colors/gitsigns-blame.lua`) that is independent of the main colorscheme. The blame text appears at the end of lines with improved contrast while maintaining a subtle background appearance.

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
- Readability and documentation
- Single-file simplicity while allowing modular growth  
- Sane defaults with easy customization points
- Learning-friendly structure with extensive comments

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


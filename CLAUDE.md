# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Overview

This is a Neovim configuration based on kickstart.nvim, providing a well-documented starting point for Neovim customization. The configuration follows a single-file approach with modular plugin loading.

## Core Architecture

### File Structure

- `init.lua` - Main configuration file containing all core settings, keymaps, and plugin configurations
- `after/lsp/*.lua` - LSP server overrides that need substantial custom logic (only `lua_ls`)
- `colors/custom.lua` - Custom colorscheme (transparent backgrounds, peach accents)
- `lua/kickstart/plugins/` - Modular plugins (all currently enabled via require in init.lua):
  - `gitsigns.lua` - Git signs, blame, and hunk navigation keymaps
  - `autopairs.lua` - Auto-close brackets, quotes, etc.
  - `debug.lua` - DAP debugger setup (Go, Python)
  - `lint.lua` - nvim-lint with eslint_d, ruff
  - `neo-tree.lua` - File explorer (right-side, text-based icons)
  - `indent_line.lua` - Indentation guides via indent-blankline.nvim
- `lua/kickstart/health.lua` - Health check for `:checkhealth`
- `lua/custom/plugins/init.lua` - Entry point for custom plugin additions (currently empty)
- `lazy-lock.json` - Plugin version lockfile

### Plugin Management

Uses lazy.nvim as the plugin manager. Core plugins include:

- **LSP**: nvim-lspconfig with Mason for auto-installation, native Neovim 0.11+ LSP config (`lsp/*.lua`)
- **Completion**: blink.cmp with LuaSnip for snippets
- **Fuzzy Finding**: Telescope with fzf-native
- **Git Integration**: gitsigns + diffview.nvim
- **Treesitter**: Syntax highlighting, code parsing, and context (nvim-treesitter-context)
- **Formatting**: conform.nvim for auto-formatting
- **Linting**: nvim-lint with eslint_d, ruff
- **Debugging**: nvim-dap with Go (delve) and Python (debugpy via uv)
- **UI**: which-key, mini.nvim (statusline, surround, text objects), undotree, todo-comments

### Key Bindings Structure

- Leader key: `<Space>`
- Search operations: `<leader>s*` (files, grep, help, etc.)
- Toggle options: `<leader>t*` (inlay hints, deleted hunks)
- Git operations: `<leader>g*` (blame, diff, history), `<leader>h*` (hunks)
- LSP operations: `gr*` prefix (Neovim 0.11 defaults for rename/code action, Telescope overrides for references/definitions)
- Format: `<leader>f` (format buffer)
- Explorer: `<leader>e` (neo-tree toggle)
- Undo tree: `<leader>u` (toggle undotree)
- Path copy: `<leader>p*` (copy absolute/relative file paths)
- Debug: `<leader>b` (breakpoint), `F1-F3` (stepping), `F5` (continue), `F7` (DAP UI)

## Development Workflows

### Plugin Management

- `:Lazy` - View plugin status and manage installations
- `:Lazy update` - Update all plugins
- `:Mason` - Manage LSP servers, formatters, and linters
- `:checkhealth` - Diagnose configuration issues

### LSP and Language Support

Configured with multiple language servers (TypeScript, Python, Rust, Go, Lua, JSON, YAML, HTML, CSS, Haskell, Java, Kotlin). Three config layers (lowest to highest priority):

1. **nvim-lspconfig defaults** — cmd, filetypes, root_dir, commands (no files needed)
2. **`after/lsp/*.lua`** — servers with substantial custom logic (only `lua_ls`)
3. **`vim.lsp.config()` in init.lua** — small overrides (settings, init_options)

To add a new language server:

1. Add entry to `servers` table in init.lua (`server_name = 'mason-package-name'`)
2. Add `vim.lsp.config()` override in init.lua if custom settings are needed
3. Only create `after/lsp/<server_name>.lua` if the server needs substantial logic (e.g., `on_init`)
4. Add formatters to `formatters_by_ft` in conform.nvim config if needed
5. Run `:Mason` to install required tools

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
- `after/lsp/*.lua` - Add LSP server configs with substantial custom logic
- `vim.lsp.config()` in init.lua for small LSP server overrides
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
- [`fd-find`](https://github.com/sharkdp/fd) for file finding (optional, Telescope uses it if available)
- [`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter) for Treesitter parser management (`brew install tree-sitter-cli`)
- Clipboard tool (`pbcopy` on macOS, `xclip`/`xsel` on Linux)
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

- Always read the latest source code and documentation (plugin READMEs, Neovim help, plugin source) before making any change
- Always explain your reasoning and cite sources before implementing — never change code without understanding why
- Always inline clear, concise and useful documentation in code
- Always explain choices and follow latest standards and best practices
- Prioritize reliable, cross-platform solutions over clever hacks
- The simplest solution is often the most correct and maintainable
- Never remove kickstart.nvim instructional comments or other educational comments
- Preserve multi-platform compatibility checks (e.g., Windows detection) even on a macOS-only setup

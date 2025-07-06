# nvim

A lean Neovim configuration based on kickstart.nvim with custom enhancements.

<img width="2354" alt="Screenshot 2025-07-06 at 4 05 04 PM" src="https://github.com/user-attachments/assets/ac727a89-0a60-4373-af12-51117794765a" />

**Philosophy**: One obvious way to do anything, text-based interface, git-centric workflow.

**Key Features**: Custom terminal integration, comprehensive git workflow, dark-plus colorscheme, right-side file explorer.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Dependencies

Required:
- `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation), [fd-find](https://github.com/sharkdp/fd#installation)
- Clipboard tool (xclip/xsel/win32yank)
- Language-specific tools (`npm`, `go`, etc. as needed)

### Install

Backup your existing configuration and clone:

```sh
git clone https://github.com/desaidn/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Post Installation

Start Neovim and plugins will auto-install:

```sh
nvim
```

## Key Bindings

### Terminal
- `<leader>th` - Horizontal split (50% height)
- `<leader>ts` - Small split (10 lines)
- `<leader>tf` - Fullscreen terminal

### Git
- `<leader>gg` - Lazygit
- `<leader>gd` - Git diff
- `<leader>hp` - Preview hunk
- `<leader>hs` - Stage hunk

### File Explorer
- `\` - Toggle neo-tree (right-side)

### LSP
- `grd` - Go to definition
- `grr` - References
- `grn` - Rename
- `K` - Hover documentation

## Configuration

Leader key is `<Space>`. Configuration is documented in `init.lua` and `CLAUDE.md`.

Use `:Lazy` to manage plugins, `:Mason` for LSP servers, and `:checkhealth` to diagnose issues.


# nvim

A lean Neovim configuration based on kickstart.nvim.

**Philosophy**: Text editing focused, minimal dependencies, tmux-integrated workflow.

## Installation

### Install Neovim

Kickstart.nvim targets _only_ the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

> For detailed installation methods (Homebrew, Bob, Flatpak, etc.), see the
> [upstream kickstart.nvim documentation](https://github.com/nvim-lua/kickstart.nvim#install-neovim).

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

### Search & Navigation

- `<leader>sf` - Find files
- `<leader>sg` - Live grep
- `<leader><leader>` - Find buffers

### Git

- `<leader>gb` - Toggle git blame
- `]c` / `[c` - Navigate git hunks

### File Explorer

- `<leader>e` - Toggle neo-tree (right-side)

### LSP

- `grd` - Go to definition
- `grr` - References
- `grn` - Rename
- `K` - Hover documentation

### Diagnostics

- `<leader>dd` - Toggle diagnostics


## Configuration

Leader key is `<Space>`. Configuration is documented in `init.lua` and `CLAUDE.md`.

Use `:Lazy` to manage plugins, `:Mason` for LSP servers, and `:checkhealth` to diagnose issues.

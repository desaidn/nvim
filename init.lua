--[[

Kickstart Guide:

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example which will only take 10-15 minutes:
    - https://learnxinyminutes.com/docs/lua/

  After understanding a bit more about Lua, you can use `:help lua-guide` as a
  reference for how Neovim integrates Lua.
  - :help lua-guide
  - (or HTML version): https://neovim.io/doc/user/lua-guide.html

  The very first thing you should do is to run the command `:Tutor` in Neovim.

  Next, run AND READ `:help`.
  This will open up a help window with some basic information
  about reading, navigating and searching the builtin help documentation.

  MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
  which is very useful when you're not exactly sure of what you're looking for.

  If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw to prevent flicker when opening directories (using neo-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
-- See `:help vim.o`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Line number management (relative number toggling + special buffer suppression)
local line_numbers_group = vim.api.nvim_create_augroup('line-numbers', { clear = true })

vim.api.nvim_create_autocmd('InsertEnter', {
  desc = 'Disable relative numbers in insert mode',
  group = line_numbers_group,
  callback = function()
    if vim.bo.buftype == '' and vim.bo.filetype ~= 'neo-tree' then vim.wo.relativenumber = false end
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Re-enable relative numbers in normal mode',
  group = line_numbers_group,
  callback = function()
    if vim.bo.buftype == '' and vim.bo.filetype ~= 'neo-tree' then vim.wo.relativenumber = true end
  end,
})

vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter', 'WinEnter', 'FileType' }, {
  desc = 'Disable line numbers for special buffers',
  group = line_numbers_group,
  callback = function()
    local buftype = vim.bo.buftype
    local filetype = vim.bo.filetype

    if buftype == 'terminal' or filetype == 'neo-tree' or filetype == 'help' or filetype == 'qf' or buftype == 'nofile' or buftype == 'prompt' then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      if buftype == 'terminal' then vim.opt_local.signcolumn = 'no' end
    end
  end,
})

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Use global statusline that spans the full width (not per-window)
vim.o.laststatus = 3

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Indentation: 2 spaces
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Display whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
--
--  Uses `vim.opt` (not `vim.o`) for table-like option handling.
--  See `:help lua-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Load custom colorscheme (see colors/custom.lua)
vim.cmd.colorscheme 'custom'

vim.o.winborder = 'rounded'

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Never show tabline (use tmux for this)
vim.o.showtabline = 0

-- [[ Diagnostic Config ]]
-- See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {},
  virtual_text = { source = 'if_many', spacing = 2 },
  -- Auto open the float when jumping with `[d` and `]d`
  jump = { float = true },
}

-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Half-page navigation with centered cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half-page down and center cursor' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half-page up and center cursor' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Copy file paths to clipboard
vim.keymap.set('n', '<leader>pa', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('Copied absolute path: ' .. path)
end, { desc = 'Copy [P]ath [A]bsolute' })

vim.keymap.set('n', '<leader>pr', function()
  local path = vim.fn.expand '%:.'
  vim.fn.setreg('+', path)
  print('Copied relative path: ' .. path)
end, { desc = 'Copy [P]ath [R]elative' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Auto-reload files when changed externally
local auto_reload_group = vim.api.nvim_create_augroup('auto-reload', { clear = true })

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  desc = 'Check if file changed on disk and reload',
  group = auto_reload_group,
  callback = function()
    if vim.fn.getcmdwintype() == '' then vim.cmd 'checktime' end
  end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  desc = 'Notify when file is reloaded',
  group = auto_reload_group,
  callback = function() vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN) end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Shared formatter config used across multiple filetypes
local prettier = { 'prettierd', 'prettier', stop_after_first = true }

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Plugins can be added via a link or github org/name. Use `opts = {}` to call setup automatically,
  --  or `config = function() ... end` for full control. Plugins support lazy loading via `event`,
  --  `cmd`, `keys`, etc. See `:help lazy.nvim-🔌-plugin-spec`
  { 'NMAC427/guess-indent.nvim', opts = {} },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      preset = 'classic', -- Use classic preset for familiar behavior
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 0,
      icons = {
        mappings = false,
        keys = {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
        { '<leader>p', group = '[P]ath', mode = { 'n', 'v' } },
        { '<leader>1', hidden = true },
        { '<leader>2', hidden = true },
        { '<leader>3', hidden = true },
        { '<leader>4', hidden = true },
        { '<leader>5', hidden = true },
        { '<leader>6', hidden = true },
        { '<leader>7', hidden = true },
        { '<leader>8', hidden = true },
        { '<leader>9', hidden = true },
        { '<leader>0', hidden = true },
      },
    },
  },

  -- Plugins can specify `dependencies` — these are full plugin specs loaded before the parent.

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- `build` runs on install/update; `cond` controls whether the plugin loads at all.
        --  If encountering errors, see telescope-fzf-native README for install instructions.
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      -- Telescope fuzzy-finds over files, LSP symbols, help, keymaps, and more.
      --  Press <c-/> (insert) or ? (normal) inside any picker to see its keymaps.
      --  See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- See `:help telescope.setup()` for defaults and customization options
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Telescope-based LSP keymaps (co-located here with other Telescope config)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf

          -- Find references for the word under your cursor.
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

          -- Jump to the implementation of the word under your cursor.
          -- Useful when your language has ways of declaring types without an actual implementation.
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

          -- Jump to the definition of the word under your cursor.
          -- This is where a variable was first declared, or where a function is defined, etc.
          -- To jump back, press <C-t>.
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

          -- Fuzzy find all the symbols in your current document.
          -- Symbols are things like variables, functions, types, etc.
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

          -- Fuzzy find all the symbols in your current workspace.
          -- Similar to document symbols, except searches over your entire project.
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

          -- Jump to the type of the word under your cursor.
          -- Useful when you're not sure what type a variable is and you want to see
          -- the definition of its *type*, not where it was *defined*.
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
        end,
      })

      -- Override default behavior and theme when searching
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch [/] in Open Files' }
      )

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- Main LSP Configuration
    -- NOTE: nvim-lspconfig is not called directly but serves as lazy.nvim's dependency
    -- anchor for mason, fidget, and blink.cmp load ordering.
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0, -- Transparency (0 = opaque, 100 = fully transparent)
              normal_hl = 'Normal', -- Use Normal highlight (transparent bg)
            },
          },
        },
      },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- LSP (Language Server Protocol) provides go-to-definition, references,
      --  completions, diagnostics, and more via external language servers
      --  (e.g., `gopls`, `lua_ls`, `rust_analyzer`).
      --
      -- Mason auto-installs these servers. Treesitter handles syntax highlighting
      --  separately — see `:help lsp-vs-treesitter` for the distinction.

      -- Runs when an LSP attaches to a buffer (e.g., opening `main.rs` triggers `rust_analyzer`)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper to avoid repeating buffer and description boilerplate for each LSP keymap.
          --  Sets the mode, buffer and description prefix for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- [[ Native LSP Configuration (Neovim 0.11+) ]]
      --
      -- Neovim 0.11 introduced native LSP configuration via vim.lsp.config() and vim.lsp.enable().
      -- Server configs are defined in the lsp/ directory (e.g., lsp/lua_ls.lua) and are
      -- automatically discovered. We only need to:
      --   1. Merge blink.cmp capabilities into each server
      --   2. Enable the servers we want
      --
      -- See `:help lsp-config` for more information.

      -- LSP servers to enable: maps server name → Mason package name.
      -- Server configs are defined in lsp/*.lua and auto-discovered by Neovim 0.11+.
      local servers = {
        lua_ls = 'lua-language-server',
        ts_ls = 'typescript-language-server',
        rust_analyzer = 'rust-analyzer',
        gopls = 'gopls',
        pyright = 'pyright',
        jsonls = 'json-lsp',
        yamlls = 'yaml-language-server',
        html = 'html-lsp',
        cssls = 'css-lsp',
        hls = 'haskell-language-server',
        jdtls = 'jdtls',
        kotlin_lsp = 'kotlin-lsp',
      }

      -- Configure and enable each server with blink.cmp capabilities
      local ensure_installed = {}
      for name, mason_pkg in pairs(servers) do
        vim.lsp.config(name, { capabilities = capabilities })
        vim.lsp.enable(name)
        table.insert(ensure_installed, mason_pkg)
      end

      -- Ensure the servers and tools above are installed via Mason
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      vim.list_extend(ensure_installed, {
        'stylua',
        'prettier',
        'prettierd',
        'eslint_d',
        'ruff',
        'markdownlint',
        'google-java-format',
        'ktlint',
      })

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = prettier,
        javascriptreact = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        json = prettier,
        jsonc = prettier,
        css = prettier,
        scss = prettier,
        html = prettier,
        markdown = prettier,
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        java = { 'google-java-format' },
        kotlin = { 'ktlint' },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          },
        },
        opts = {},
      },
    },
    opts = {
      keymap = {
        -- Presets: 'default' (<c-y> accept), 'super-tab', 'enter', 'none'
        --  See `:help ins-completion` and `:help blink-cmp-config-keymap`
        --
        -- Common keymaps (all presets):
        --  <c-space>: open menu/docs  |  <c-n>/<c-p>: navigate  |  <c-e>: dismiss
        --  <tab>/<s-tab>: snippet jump  |  <c-k>: signature help
        preset = 'enter',
      },

      -- For advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps

      appearance = {
        kind_icons = {},
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true, auto_show_delay_ms = 200 },

        -- Customize completion menu appearance
        menu = {
          draw = {
            -- Disable icons by showing only text
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
            },
          },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = false }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end

      -- ... and there is more!
      --  Check out: https://github.com/nvim-mini/mini.nvim
    end,
  },

  -- [[ Small Utility Plugins ]]
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Undo tree visualization
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = { { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle [U]ndo tree' } },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- Git diff and file history
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git [D]iff' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File [H]istory' },
    },
    opts = {
      use_icons = false,
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    -- Parser installation in `build` (runs on install/update) vs `config` (runs every startup).
    -- This prevents parser checks on every nvim launch.
    build = function()
      require('nvim-treesitter')
        .install({
          'bash',
          'c',
          'diff',
          'html',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
          'java',
          'kotlin',
          'javascript',
          'typescript',
          'tsx',
          'css',
          'scss',
          'json',
          'yaml',
          'toml',
          'dockerfile',
          'sql',
          'regex',
          'gitignore',
          'gitcommit',
          'python',
          'go',
          'rust',
          'haskell',
        })
        :wait(60000)
    end,
    config = function()
      require('nvim-treesitter').setup {}

      -- Languages with poor treesitter support
      local skip_langs = { ruby = true, smithy = true }
      local max_filesize = 100 * 1024 -- 100 KB

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(event.match) or event.match
          if skip_langs[lang] then return end

          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
          if ok and stats and stats.size > max_filesize then return end

          pcall(vim.treesitter.start, event.buf, lang)
        end,
      })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  { -- Show treesitter context
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },

  -- Kickstart plugin modules (all enabled)
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.indent_line',

  -- Add your own plugins to `lua/custom/plugins/*.lua` and import them here.
  --  See `:help lazy.nvim-🔌-plugin-spec`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    icons = {
      cmd = '[cmd]',
      config = '[cfg]',
      event = '[event]',
      ft = '[ft]',
      init = '[init]',
      keys = '[keys]',
      plugin = '[plugin]',
      runtime = '[rt]',
      require = '[req]',
      source = '[src]',
      start = '[start]',
      task = '[task]',
      lazy = '[lazy]',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

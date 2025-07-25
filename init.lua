--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Disable netrw to prevent flicker when opening directories
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Auto-toggle relative numbers based on mode
vim.api.nvim_create_augroup('relative-numbers', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', {
  group = 'relative-numbers',
  callback = function()
    vim.wo.relativenumber = false
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'relative-numbers',
  callback = function()
    vim.wo.relativenumber = true
  end,
})

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Use global statusline that spans the full width (not per-window)
vim.o.laststatus = 3

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Default indentation settings
vim.o.tabstop = 2 -- Number of spaces that a tab counts for
vim.o.shiftwidth = 2 -- Number of spaces for each indentation level
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.softtabstop = 2 -- Number of spaces for tab in insert mode
vim.o.smartindent = true -- Smart indentation for new lines

-- Save undo history
vim.o.undofile = true

-- Auto-reload buffers when files change on disk
vim.o.autoread = true

-- Enhanced autoread: trigger on focus, buffer enter, and cursor hold
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    if vim.fn.mode() ~= 'c' then
      vim.cmd 'checktime'
    end
  end,
})

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

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Custom Tabline Configuration ]]
-- Enable tabline and configure minimal tab experience
vim.o.showtabline = 2 -- Always show tabline

-- Custom tabline function for minimal, informative tabs
function _G.custom_tabline()
  local tabline = ''
  local current_tab = vim.fn.tabpagenr()
  local total_tabs = vim.fn.tabpagenr '$'

  for tab_num = 1, total_tabs do
    local bufnr = vim.fn.tabpagebuflist(tab_num)[vim.fn.tabpagewinnr(tab_num)]
    local filename = vim.fn.bufname(bufnr)
    local modified = vim.fn.getbufvar(bufnr, '&modified') == 1
    local buftype = vim.fn.getbufvar(bufnr, '&buftype')

    -- Get clean filename
    local display_name
    if filename == '' then
      display_name = '[No Name]'
    elseif buftype == 'terminal' then
      display_name = 'Terminal'
    else
      display_name = vim.fn.fnamemodify(filename, ':t')
      if display_name == '' then
        display_name = '[No Name]'
      end
    end

    -- Truncate long names
    if #display_name > 20 then
      display_name = display_name:sub(1, 17) .. '...'
    end

    -- Build tab content with tab number and extra padding for thickness
    local tab_content = '  ' .. tab_num .. ': ' .. display_name

    -- Add modified indicator
    if modified then
      tab_content = tab_content .. ' •'
    end

    tab_content = tab_content .. '  '

    -- Add highlight groups and click handlers
    if tab_num == current_tab then
      tabline = tabline .. '%#TabLineSel#'
    else
      tabline = tabline .. '%#TabLine#'
    end

    -- Add tab number for click handling
    tabline = tabline .. '%' .. tab_num .. 'T' .. tab_content
  end

  -- Fill the rest with TabLineFill
  tabline = tabline .. '%#TabLineFill#%T'

  return tabline
end

-- Set the custom tabline
vim.o.tabline = '%!v:lua.custom_tabline()'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Half-page navigation with centered cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half-page down and center cursor' })
vim.keymap.set('n', '<C-z>', '<C-u>zz', { desc = 'Half-page up and center cursor' })

-- Tab navigation keymaps
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = '[T]ab [C]lose' })
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<CR>', { desc = '[T]ab [O]nly (close others)' })
vim.keymap.set('n', 'gt', '<cmd>tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', 'gT', '<cmd>tabprevious<CR>', { desc = 'Go to previous tab' })
-- Tab number navigation keymaps (1-9 for tabs 1-9, 0 for tab 10)
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('n', '<leader>4', '4gt')
vim.keymap.set('n', '<leader>5', '5gt')
vim.keymap.set('n', '<leader>6', '6gt')
vim.keymap.set('n', '<leader>7', '7gt')
vim.keymap.set('n', '<leader>8', '8gt')
vim.keymap.set('n', '<leader>9', '9gt')
vim.keymap.set('n', '<leader>0', '10gt')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
local function setup_window_navigation()
  local keymaps = {
    { '<C-h>', '<C-w><C-h>', 'Move focus to the left window' },
    { '<C-l>', '<C-w><C-l>', 'Move focus to the right window' },
    { '<C-j>', '<C-w><C-j>', 'Move focus to the lower window' },
    { '<C-k>', '<C-w><C-k>', 'Move focus to the upper window' },
  }
  for _, keymap in ipairs(keymaps) do
    vim.keymap.set('n', keymap[1], keymap[2], { desc = keymap[3] })
  end
end
setup_window_navigation()

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Terminal buffer configuration
local terminal_group = vim.api.nvim_create_augroup('terminal-config', { clear = true })
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter', 'WinEnter' }, {
  desc = 'Configure terminal buffers without line numbers',
  group = terminal_group,
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.bo.modifiable = true
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = 'no'
    end
  end,
})

-- [[ Terminal Configuration ]]
-- Terminal mode escape mapping
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Persistent fullscreen terminal buffer function
local function terminal_fullscreen()
  vim.cmd 'tabnew'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end

vim.keymap.set('n', '<leader>tf', terminal_fullscreen, { desc = '[T]erminal [F]ullscreen' })

-- [[ Diagnostic Configuration ]]
-- Diagnostic keymaps
-- Note: Diagnostic list functionality now handled by trouble.nvim with <leader>dd
vim.keymap.set('n', '<leader>Td', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled { bufnr = 0 })
end, { desc = '[T]oggle [D]iagnostics for current buffer' })

-- Diagnostic config
-- See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'if_many',
    wrap = true,
    max_width = 80,
    max_height = 20,
  },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

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

  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- Color palette for consistent theming
      local colors = {
        bg_primary = '#1e1e1e',
        bg_secondary = '#2a2d2e',
        fg_primary = '#ffffff',
        fg_secondary = '#cccccc',
        fg_tertiary = '#858585',
        fg_muted = '#6a6a6a',
        accent_blue = '#007acc',
        accent_green = '#16825d',
        accent_red = '#c5282f',
        accent_orange = '#af5f00',
        accent_dark_red = '#d70000',
        accent_olive = '#5f5f00',
        accent_gray = '#444444',
        indent_marker = '#464647',
        git_added = '#73c991',
        git_modified = '#e2c08d',
        git_deleted = '#f85149',
      }

      require('vscode').setup {
        style = 'dark',
        transparent = false,
        italic_comments = true,
        underline_links = true,
        disable_nvimtree_bg = true,
        group_overrides = {
          -- Status line
          StatusLine = { fg = colors.fg_primary, bg = colors.accent_blue, bold = false },
          StatusLineNC = { fg = colors.fg_primary, bg = colors.accent_blue, bold = false },

          -- Mini statusline modes
          MiniStatuslineModeNormal = { bg = colors.accent_green, fg = colors.fg_primary, bold = true },
          MiniStatuslineModeInsert = { bg = colors.accent_red, fg = colors.fg_primary, bold = true },
          MiniStatuslineModeVisual = { bg = colors.accent_orange, fg = colors.fg_primary, bold = true },
          MiniStatuslineModeReplace = { bg = colors.accent_dark_red, fg = colors.fg_primary, bold = true },
          MiniStatuslineModeCommand = { bg = colors.accent_olive, fg = colors.fg_primary, bold = true },
          MiniStatuslineModeOther = { bg = colors.accent_gray, fg = colors.fg_primary, bold = true },

          -- Mini statusline components
          MiniStatuslineFilename = { bg = colors.accent_blue, fg = colors.fg_primary, bold = false },
          MiniStatuslineFileinfo = { bg = colors.accent_blue, fg = colors.fg_primary, bold = false },
          MiniStatuslineDevinfo = { bg = colors.accent_blue, fg = colors.fg_primary, bold = false },
          MiniStatuslineInactive = { bg = colors.accent_blue, fg = colors.fg_primary, bold = false },

          -- Line numbers and cursor
          LineNr = { bg = colors.bg_primary, fg = colors.fg_tertiary },
          CursorLine = { bg = colors.bg_secondary },
          CursorLineNr = { fg = colors.fg_primary, bg = colors.bg_secondary, bold = true },

          -- NeoTree styling
          NeoTreeNormal = { bg = colors.bg_primary, fg = colors.fg_secondary },
          NeoTreeNormalNC = { bg = colors.bg_primary, fg = colors.fg_secondary },
          NeoTreeWinSeparator = { bg = colors.bg_primary, fg = colors.bg_primary },
          NeoTreeEndOfBuffer = { bg = colors.bg_primary, fg = colors.bg_primary },
          NeoTreeRootName = { fg = colors.fg_primary, bold = true },
          NeoTreeDirectoryName = { fg = colors.fg_secondary },
          NeoTreeDirectoryIcon = { fg = colors.fg_secondary },
          NeoTreeFileName = { fg = colors.fg_secondary },
          NeoTreeFileIcon = { fg = colors.fg_secondary },
          NeoTreeIndentMarker = { fg = colors.indent_marker },
          NeoTreeExpander = { fg = colors.fg_secondary },
          NeoTreeDotfile = { fg = colors.fg_muted },
          NeoTreeHiddenByName = { fg = colors.fg_muted },
          NeoTreeGitAdded = { fg = colors.git_added },
          NeoTreeGitConflict = { fg = colors.git_deleted },
          NeoTreeGitDeleted = { fg = colors.git_deleted },
          NeoTreeGitIgnored = { fg = colors.fg_muted },
          NeoTreeGitModified = { fg = colors.git_modified },
          NeoTreeGitUnstaged = { fg = colors.git_deleted },
          NeoTreeGitUntracked = { fg = colors.git_added },
          NeoTreeGitStaged = { fg = colors.git_added },

          TabLine = { bg = colors.bg_primary, fg = colors.fg_tertiary },
          TabLineSel = { bg = colors.bg_secondary, fg = colors.fg_primary, bold = true },
          TabLineFill = { bg = colors.bg_primary },
        },
      }
      vim.cmd.colorscheme 'vscode'
    end,
  },

  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  { 'NMAC427/guess-indent.nvim', opts = {} }, -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'classic', -- Use classic preset for familiar behavior
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = function(ctx)
        return ctx.plugin and 0 or 0 -- Always show immediately
      end,
      -- Configure triggers to work in all relevant modes
      triggers = {
        { '<leader>', mode = { 'n', 'v' } },
      },
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
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
        { '<leader>t', group = '[T]erminal/[T]abs', mode = { 'n', 'v' } },
        { '<leader>T', group = '[T]oggle', mode = { 'n', 'v' } },
        { '<leader>e', group = '[E]xplorer', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
        { '<leader>c', group = '[C]laude', mode = { 'n', 'v' } },
        { '<leader>f', group = '[F]ormat', mode = { 'n', 'v' } },
        { '<leader>q', group = '[Q]uickfix', mode = { 'n', 'v' } },
        { '<leader>r', group = '[R]ename/Replace', mode = { 'n', 'v' } },
        { '<leader>d', group = '[D]iagnostics', mode = { 'n', 'v' } },
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

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'

      -- Setup telescope keymaps
      local function setup_telescope_keymaps()
        local keymaps = {
          { '<leader>sh', builtin.help_tags, '[S]earch [H]elp' },
          { '<leader>sk', builtin.keymaps, '[S]earch [K]eymaps' },
          { '<leader>sf', builtin.find_files, '[S]earch [F]iles' },
          { '<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope' },
          { '<leader>sw', builtin.grep_string, '[S]earch current [W]ord' },
          { '<leader>sg', builtin.live_grep, '[S]earch by [G]rep' },
          { '<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics' },
          { '<leader>sr', builtin.resume, '[S]earch [R]esume' },
          { '<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)' },
          { '<leader><leader>', builtin.buffers, '[ ] Find existing buffers' },
        }
        for _, keymap in ipairs(keymaps) do
          vim.keymap.set('n', keymap[1], keymap[2], { desc = keymap[3] })
        end
      end
      setup_telescope_keymaps()

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[N]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, '[O]pen Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[O]pen [W]orkspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>Th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        ts_ls = {
          settings = {
            typescript = {
              -- Support for Bun runtime
              preferences = {
                includePackageJsonAutoImports = 'auto',
              },
            },
            javascript = {
              preferences = {
                includePackageJsonAutoImports = 'auto',
              },
            },
          },
        },

        -- Lua
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        -- Additional language servers
        pyright = {}, -- Python
        rust_analyzer = {}, -- Rust
        gopls = {}, -- Go
        jsonls = {}, -- JSON
        yamlls = {}, -- YAML
        html = {}, -- HTML
        cssls = {}, -- CSS
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        -- JavaScript/TypeScript tools
        'prettier', -- Code formatter
        'prettierd', -- Faster prettier daemon
        'eslint_d', -- ESLint daemon for faster linting
        'typescript-language-server', -- TypeScript LSP server
        -- Additional language servers
        'pyright', -- Python LSP
        'rust-analyzer', -- Rust LSP
        'gopls', -- Go LSP
        'json-lsp', -- JSON LSP
        'yaml-language-server', -- YAML LSP
        'html-lsp', -- HTML LSP
        'css-lsp', -- CSS LSP
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
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
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
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
      formatters_by_ft = (function()
        local prettier_config = { 'prettierd', 'prettier', stop_after_first = true }
        local formatters = { lua = { 'stylua' } }

        -- JavaScript/TypeScript formatting with Prettier
        local js_ts_filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
        for _, filetype in ipairs(js_ts_filetypes) do
          formatters[filetype] = prettier_config
        end

        -- Other Prettier-supported filetypes
        local prettier_filetypes = { 'json', 'jsonc', 'css', 'scss', 'html', 'markdown' }
        for _, filetype in ipairs(prettier_filetypes) do
          formatters[filetype] = prettier_config
        end

        -- Conform can also run multiple formatters sequentially
        -- formatters.python = { "isort", "black" }

        return formatters
      end)(),
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
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'enter',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        -- Disable all icons
        use_nvim_cmp_as_default = false,
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
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- Lazygit integration
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
    end,
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open [G]it [G]UI' },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
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
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
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
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
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
        'jsonc',
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
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        -- Disable highlighting for large files to improve performance
        disable = function(lang, buf)
          if lang == 'ruby' or lang == 'smithy' then
            return true
          end
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby', 'smithy' },
      },
      indent = { enable = true, disable = { 'ruby', 'smithy' } },
    },
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
    opts = {
      enable = true,
      max_lines = 20,
      min_window_height = 20,
      line_numbers = true,
      multiline_threshold = 1,
      trim_scope = 'outer',
      mode = 'cursor',
    },
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- trouble.nvim - Enhanced diagnostics and lists UI
  {
    'folke/trouble.nvim',
    opts = {
      focus = true,
    },
    cmd = 'Trouble',
    keys = {
      { '<leader>dd', '<cmd>Trouble diagnostics toggle<cr>', desc = '[D]iagnostics trouble' },
      { '<leader>dr', '<cmd>Trouble lsp_references toggle<cr>', desc = '[D]iagnostics [R]eferences' },
      { '<leader>ds', '<cmd>Trouble symbols toggle focus=false<cr>', desc = '[D]iagnostics [S]ymbols' },
    },
  },

  -- oil.nvim - Edit directories like buffers
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = false, -- Don't replace netrw, we have neo-tree
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { '<leader>ef', '<cmd>Oil<cr>', desc = '[E]dit [F]iles (oil)' },
    },
  },

  -- toggleterm.nvim - Persistent toggle terminal for quick commands
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = math.floor(vim.o.lines * 0.4),
      direction = 'horizontal',
      close_on_exit = false,
      persist_mode = true,
      persist_size = true,
      start_in_insert = true,
    },
    keys = {
      { '<leader>tt', '<cmd>ToggleTerm<cr>', desc = '[T]erminal [T]oggle', mode = 'n' },
    },
  },

  -- Diffview.nvim for viewing git diffs as file tree
  {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup {
        diff_binaries = false,
        enhanced_diff_hl = true, -- Keep subtle highlighting for readability
        use_icons = vim.g.have_nerd_font, -- Use icons only if nerd font available
        show_help_hints = true,
        watch_index = true, -- Auto-update when git index changes
        view = {
          default = {
            layout = 'diff2_horizontal',
            disable_diagnostics = true,
            winbar_info = true,
          },
          merge_tool = {
            layout = 'diff3_horizontal',
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = 'diff2_horizontal',
            disable_diagnostics = true,
            winbar_info = true,
          },
        },
        file_panel = {
          listing_style = 'tree',
          tree_options = {
            flatten_dirs = true,
            folder_statuses = 'only_folded',
          },
          win_config = {
            position = 'right',
            width = 50,
            height = 10,
          },
        },
        signs = {
          fold_closed = '',
          fold_open = '',
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = 'first-parent',
                follow = true,
              },
              multi_file = {
                diff_merges = 'first-parent',
              },
            },
          },
          win_config = {
            position = 'bottom',
            height = 16,
          },
        },
      }

      -- State for persisting diff comparison
      local last_diff_ref = nil

      -- Custom command and toggle function
      local function toggle_diff_compare()
        local diffview_lib = require 'diffview.lib'
        if diffview_lib.get_current_view() then
          vim.cmd 'DiffviewClose'
        else
          if last_diff_ref then
            vim.cmd('DiffviewOpen ' .. last_diff_ref)
          else
            local ref = vim.fn.input 'Enter git refs to compare (e.g. main..feature, abc123, HEAD~2): '
            if ref ~= '' then
              last_diff_ref = ref
              vim.cmd('DiffviewOpen ' .. ref)
            end
          end
        end
      end

      vim.api.nvim_create_user_command('DiffCompare', function()
        local ref = vim.fn.input 'Enter git refs to compare (e.g. main..feature, abc123, HEAD~2): '
        if ref ~= '' then
          last_diff_ref = ref
          vim.cmd('DiffviewOpen ' .. ref)
        end
      end, { desc = 'Compare arbitrary git references' })

      -- Function to open current file in a new buffer
      local function open_file_in_buffer()
        local file_path = vim.api.nvim_buf_get_name(0)
        if file_path and file_path ~= '' then
          local line_num = vim.api.nvim_win_get_cursor(0)[1]
          vim.cmd('tabnew ' .. file_path)
          vim.api.nvim_win_set_cursor(0, { line_num, 0 })
        end
      end

      -- Keymaps
      vim.keymap.set('n', '<leader>gd', toggle_diff_compare, { desc = 'Toggle git diff view' })
      vim.keymap.set('n', '<leader>gc', '<cmd>DiffCompare<cr>', { desc = 'Compare git refs' })
      vim.keymap.set('n', '<leader>gr', '<cmd>DiffviewRefresh<cr>', { desc = 'Refresh git diff view' })
      vim.keymap.set('n', '<leader>ge', open_file_in_buffer, { desc = 'Edit current file in new buffer' })
      vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'View current file history' })
      vim.keymap.set('n', '<leader>gl', function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local file = vim.api.nvim_buf_get_name(0)
        if file and file ~= '' then
          vim.cmd('DiffviewFileHistory -L' .. line .. ',' .. line .. ':' .. vim.fn.fnamemodify(file, ':~:.'))
        end
      end, { desc = 'View current line history' })
    end,
  },

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

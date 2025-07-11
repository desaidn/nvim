-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle [E]xplorer', silent = true },
  },
  opts = {
    window = {
      position = 'right',
      width = function()
        return math.floor(vim.o.columns * 0.25)
      end,
    },
    default_component_configs = {
      icon = {
        folder_closed = '[+]',
        folder_open = '[-]',
        folder_empty = '[.]',
        default = '',
      },
      git_status = {
        symbols = {
          added = '+',
          modified = '~',
          deleted = '-',
          renamed = 'r',
          untracked = '?',
          ignored = '',
          unstaged = 'u',
          staged = 's',
          conflict = 'c',
        },
      },
    },
    filesystem = {
      hijack_netrw_behavior = 'disabled',
      filtered_items = {
        hide_dotfiles = false,
        hide_hidden = false,
        hide_gitignored = false,
        hide_by_name = {},
        hide_by_pattern = {},
        always_show = {},
        never_show = {},
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      use_libuv_file_watcher = true,
      window = {
        mappings = {},
      },
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(file_path)
          vim.schedule(function()
            local neo_tree_wins = vim.tbl_filter(function(win)
              return vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'neo-tree'
            end, vim.api.nvim_list_wins())

            if #neo_tree_wins > 0 then
              vim.api.nvim_set_current_win(neo_tree_wins[1])
            end
          end)
        end,
      },
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.wo.number = true
          vim.wo.relativenumber = true
        end,
      },
    },
  },
}

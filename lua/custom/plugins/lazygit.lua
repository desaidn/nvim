--- Opens lazygit in a dedicated tab. If already open, focuses the existing tab.
--- Quitting lazygit (q) automatically closes the tab and returns to the previous buffer.
--- Requires: lazygit (https://github.com/jesseduffield/lazygit)
local lazygit_buf = nil

local function toggle_lazygit()
  if lazygit_buf and vim.api.nvim_buf_is_valid(lazygit_buf) then
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
        if vim.api.nvim_win_get_buf(win) == lazygit_buf then
          vim.api.nvim_set_current_tabpage(tab)
          vim.api.nvim_set_current_win(win)
          vim.api.nvim_command('startinsert')
          return
        end
      end
    end
  end

  vim.api.nvim_command('tabnew')
  lazygit_buf = vim.api.nvim_get_current_buf()
  vim.fn.jobstart('lazygit', {
    term = true,
    on_exit = function(_, _, _)
      if lazygit_buf and vim.api.nvim_buf_is_valid(lazygit_buf) then
        vim.api.nvim_buf_delete(lazygit_buf, { force = true })
      end
      lazygit_buf = nil
    end,
  })
  vim.api.nvim_command('startinsert')
end

return {
  'lazygit',
  virtual = true,
  keys = {
    { '<leader>gg', toggle_lazygit, desc = 'Lazygit' },
  },
}

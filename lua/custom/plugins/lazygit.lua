--- Opens lazygit in a fullscreen floating window.
--- Quitting lazygit (q) automatically closes the float and returns to the previous buffer.
--- Requires: lazygit (https://github.com/jesseduffield/lazygit)
local function open_lazygit()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = vim.o.columns
  local height = vim.o.lines

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height - 2,
    row = 0,
    col = 0,
    style = 'minimal',
    border = 'none',
  })

  vim.api.nvim_set_option_value('winhl', 'NormalFloat:Normal', { win = vim.api.nvim_get_current_win() })

  vim.fn.jobstart('lazygit', {
    term = true,
    on_exit = function(_, _, _)
      if buf and vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
    end,
  })
  vim.cmd.startinsert()
end

return {
  'lazygit',
  virtual = true,
  keys = {
    { '<leader>gg', open_lazygit, desc = 'Lazygit' },
  },
}

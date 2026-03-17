--- Toggleable lazygit in a fullscreen floating window.
--- <leader>g opens lazygit, <leader>g again hides it (preserving state).
--- Quitting lazygit (q) fully cleans up the buffer and window.
--- Requires: lazygit (https://github.com/jesseduffield/lazygit)
local state = { buf = nil, win = nil }

local function float_opts()
  return {
    relative = 'editor',
    width = vim.o.columns,
    height = vim.o.lines - 2,
    row = 0,
    col = 0,
    style = 'minimal',
    border = 'none',
  }
end

local function toggle_lazygit()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    state.win = nil
    return
  end

  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    state.win = vim.api.nvim_open_win(state.buf, true, float_opts())
    vim.api.nvim_set_option_value('winhl', 'NormalFloat:Normal', { win = state.win })
    vim.cmd.startinsert()
    return
  end

  state.buf = vim.api.nvim_create_buf(false, true)
  state.win = vim.api.nvim_open_win(state.buf, true, float_opts())
  vim.api.nvim_set_option_value('winhl', 'NormalFloat:Normal', { win = state.win })

  vim.fn.jobstart('lazygit', {
    term = true,
    on_exit = function()
      if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
        vim.api.nvim_buf_delete(state.buf, { force = true })
      end
      state.buf = nil
      state.win = nil
    end,
  })

  vim.keymap.set('t', '<leader>g', toggle_lazygit, { buffer = state.buf, desc = 'Toggle Lazygit' })
  vim.cmd.startinsert()
end

return {
  'lazygit',
  virtual = true,
  keys = {
    { '<leader>g', toggle_lazygit, desc = 'Lazygit' },
  },
}

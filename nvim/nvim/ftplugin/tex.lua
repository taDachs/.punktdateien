local function close_environment()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

  local regex = "\\begin{([^}]+)}"

  -- Test string: \begin{lol}
  local env = string.match(current_line, regex)
  if not env then
    return
  end
  env = "\\end{" .. env .. "}"
  vim.api.nvim_buf_set_lines(0, row, row, true, {env})
  vim.api.nvim_command('normal j==k')
end

vim.keymap.set('n', '<leader>ce', close_environment, { silent = true, noremap = true })

vim.opt.textwidth = 100

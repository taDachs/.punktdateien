local M = {}

function M.setup()
  local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
  })

  local bufWriteGrp = vim.api.nvim_create_augroup("BufferWrite", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePre", {
    command = [[%s/\s\+$//e]],
    group = bufWriteGrp,
  })
end

return M

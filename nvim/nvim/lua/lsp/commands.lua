local M = {}

function M.setup()
  vim.api.nvim_create_user_command("FormatBuffer", vim.lsp.buf.format, {})
end

return M

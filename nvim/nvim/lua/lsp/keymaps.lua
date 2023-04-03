local M = {}

function M.setup()
  -- LSP
  -- gd : goto definition
  vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { silent = true, noremap = true })
  -- gD : goto declaration
  vim.keymap.set("n", "gD", require("telescope.builtin").lsp_type_definitions, { silent = true, noremap = true })
  -- gr : goto references
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { silent = true, noremap = true })
  -- gi : goto implementation
  vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, { silent = true, noremap = true })
  -- K : show help
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, noremap = true })
  -- g? : show diagnostic
  vim.keymap.set("n", "g?", vim.diagnostic.open_float, { silent = true, noremap = true })
  vim.keymap.set("n", "gl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
  -- <C-b> : help with signature
  vim.keymap.set("n", "<C-b>", vim.lsp.buf.signature_help, { silent = true, noremap = true })
  -- <C-n> : go to previous
  vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, { silent = true, noremap = true })
  -- <C-P> : go to next
  vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, { silent = true, noremap = true })
  -- leader rn : rename
  vim.keymap.set("n", "<leader>rn", ':IncRename <C-r>=expand("<cword>")<CR>', { noremap = true })
  -- leader ca : code action
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, noremap = true })
  -- open trouble.nvim
  vim.keymap.set("n", "<leader>st", function()
    -- vim.diagnostic.setqflist({ open=false })
    vim.cmd("TroubleToggle")
  end, { silent = true, noremap = true })
end

return M

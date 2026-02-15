vim.api.nvim_set_keymap("n", "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ci", "<cmd>LspClangdShowSymbolInfo<Cr>", { silent = true, noremap = true })

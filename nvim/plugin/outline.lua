vim.pack.add {
  "https://github.com/hedyhli/outline.nvim"
}

require "outline".setup()
vim.keymap.set("n", "gO", "<cmd>Outline<cr>", { desc = "Outline" })

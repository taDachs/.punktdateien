vim.pack.add {
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
}

require "nvim-tree".setup({
  view = {
    width = 50,
  },
})

vim.keymap.set("n", "<leader>tt", ":NvimTreeFindFileToggle<cr>", { desc = "Toggle Tree" })

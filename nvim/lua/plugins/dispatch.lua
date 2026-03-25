return {
  {
    "tpope/vim-dispatch",
    config = function()
      vim.keymap.set("n", "<leader>m", "<cmd>Make<CR>", { desc = "Make [dispatch]" })
    end,
  },
}

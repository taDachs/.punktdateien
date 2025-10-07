vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
})


local snacks = require "snacks"
snacks.setup {
  bigfile = {},
  picker = {},
}

vim.keymap.set("n",
  "<leader>fh",
  function()
    snacks.picker.help()
  end,
  { desc = "[F]ind [H]elp", })
vim.keymap.set("n",
  "<leader>fk",
  function()
    snacks.picker.keymaps()
  end,
  { desc = "[F]ind [K]eymaps", })
vim.keymap.set("n",
  "<leader>ff",
  function()
    snacks.picker.files()
  end,
  { desc = "[F]ind [F]iles", })
vim.keymap.set("n",
  "<leader>f/",
  function()
    snacks.picker.grep_word()
  end,
  { desc = "[F]ind current word", })
vim.keymap.set("n",
  "<leader>fg",
  function()
    snacks.picker.grep()
  end,
  { desc = "[F]ind [G]rep", })
vim.keymap.set("n",
  "<leader>fd",
  function()
    snacks.picker.diagnostics()
  end,
  { desc = "[F]ind [D]iagnostics", })
vim.keymap.set("n",
  "<leader>f.",
  function()
    snacks.picker.recent()
  end,
  { desc = "[F]ind recent files", })
vim.keymap.set("n",
  "<leader>fr",
  function()
    snacks.picker.resume()
  end,
  { desc = "[F]ind [R]esume", })
vim.keymap.set("n",
  "<leader><space>",
  function()
    snacks.picker.buffers()
  end,
  { desc = "[ ] Find existing buffers", })

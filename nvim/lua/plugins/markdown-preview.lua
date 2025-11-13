vim.pack.add({
  { src = "https://github.com/iamcco/markdown-preview.nvim" }
})

vim.fn["mkdp#util#install"]()

vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_command_for_global = 0

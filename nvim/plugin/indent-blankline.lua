vim.pack.add {
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim", }
}

require "ibl".setup({
  scope = {
    show_start = false,
    show_end = false,
  }
})

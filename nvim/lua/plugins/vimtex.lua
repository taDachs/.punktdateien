vim.pack.add {
  "https://github.com/lervag/vimtex"
}

vim.opt.textwidth = 100
vim.opt.spell = true

vim.g.vimtex_view_method = "zathura"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "vimtex#fold#level(v:lnum)"
vim.opt.foldtext = "vimtex#fold#text()"

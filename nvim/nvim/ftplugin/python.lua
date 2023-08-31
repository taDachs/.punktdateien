vim.api.nvim_win_set_option(0, "colorcolumn", "100")
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.cmd([[compiler mypy]])
-- vim.o.formatprg = "black --line-length=100 --quiet -"

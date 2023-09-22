vim.opt.spell = true

vim.opt.textwidth = 100

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.cmd("let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'python']")

vim.cmd([[hi! link Conceal Special]])

-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()

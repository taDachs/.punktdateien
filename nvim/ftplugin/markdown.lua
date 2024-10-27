vim.opt.spell = true

vim.opt.textwidth = 100

vim.cmd("let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'python']")

vim.opt.conceallevel=2

vim.cmd([[hi! link Conceal Special]])

-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()

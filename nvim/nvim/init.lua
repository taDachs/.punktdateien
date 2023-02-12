vim.opt.termguicolors = true
vim.opt.syntax = "enabled"
vim.opt.spell = true

local plugins = require "plugins"
local mappings = require "mappings"
local lsp = require "lsp-config"
local opts = require "opts"

vim.cmd.colorscheme "kit"

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

local bufWriteGrp = vim.api.nvim_create_augroup("BufferWrite", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = bufWriteGrp,
})

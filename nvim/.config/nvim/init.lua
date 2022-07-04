vim.opt.termguicolors = true
vim.opt.syntax = "enabled"

local plugins = require("plugins")
local mappings = require("mappings")
local lsp = require("lsp-config")

-- color shit
vim.cmd("color kit")

-- softtabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- color column
vim.opt.colorcolumn = "100"

-- spelling
vim.opt.spelllang = "en_us"

-- persistent undo
vim.opt.undofile = true

-- relaive numbers
vim.opt.relativenumber = true
vim.opt.number = true

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

local rosGrp = vim.api.nvim_create_augroup("Ros", { clear = true })
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.launch"},
  command = "setf xml",
  group = bufWriteGrp,
})

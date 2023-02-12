-- softtabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- split always right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show 10 lines below and above cursor
vim.opt.scrolloff = 10

-- vim.opt.display = "lastline"
-- vim.o.ch = 0
-- vim.o.ls = 0

-- color column
vim.opt.colorcolumn = "100"

-- spelling
vim.opt.spelllang = "en_us"

-- persistent undo
vim.opt.undofile = true

-- relaive numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.diagnostic.config { virtual_lines = false }

-- options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.syntax = "enabled"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 3
vim.opt.colorcolumn = "100"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.undofile = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.updatetime = 500
vim.g.tex_flavor = "latex"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.wrap = false

-- improve cmd message handling if available
local ok, extui = pcall(require, "vim._extui")
if ok and type(extui.enable) == "function" then
  vim.o.cmdheight = 0;
  extui.enable({
    enable = true,
    msg = { -- Options related to the message module.
      ---@type 'cmd'|'msg' Type of window used to place messages, either in the
      ---cmdline or in a separate ephemeral message box window.
      target = 'msg',
      timeout = 4000,
    },
  })
end

-- highlight trailing whitespace
vim.cmd [[match errorMsg /\s\+$/]]

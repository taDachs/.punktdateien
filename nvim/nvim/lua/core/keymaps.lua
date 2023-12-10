local M = {}
local util = require("core.util")

function M.setup()
  vim.keymap.set("n", "<space>", "<nop>", { noremap = true })
  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"
  -- vim.cmd("let mapleader=\"\\<Space>\"")

  -- remap esc to jk
  vim.keymap.set("i", "jk", "<esc>", { noremap = true })
  -- vim.keymap.set("i", "<esc>", "<nop>", { noremap = true })

  -- move text
  vim.keymap.set("n", "L", ">>", { noremap = true })
  vim.keymap.set("n", "H", "<<", { noremap = true })
  vim.keymap.set("x", "L", ">`[V`]", { noremap = true })
  vim.keymap.set("x", "H", "<`[V`]", { noremap = true })
  vim.keymap.set("x", "J", "dp`[V`]", { noremap = true })
  vim.keymap.set("x", "K", "dkP`[V`]", { noremap = true })
  
  -- copy to clipboard
  vim.keymap.set("n", "<leader>y", '"+yy', { noremap = true })
  vim.keymap.set("x", "<leader>y", '"+y', { noremap = true })
  vim.keymap.set("n", "<leader>p", '"+p', { noremap = true })

  -- dont store {} on jumplist because i dont wanna
  vim.keymap.set("n", "}", '<cmd>execute "keepjumps norm! " . v:count1 . "}"<cr>', { noremap = true })
  vim.keymap.set("n", "{", '<cmd>execute "keepjumps norm! " . v:count1 . "{"<cr>', { noremap = true })

  -- J deletes leading spaces
  -- vim.api.nvim_set_keymap('n', 'J', 'Jdw', { noremap = true })

  -- <leader>rw -- remove wrapping function call
  vim.keymap.set("n", "<leader>rw", "dt(ds(", { remap = true })
  vim.keymap.set("n", "<C-w>z", "<C-w>|")

  -- unload buffer
  vim.keymap.set("n", "<leader>q", "<cmd>bd<Cr>", { silent = true, noremap = true })

  -- run make
  vim.keymap.set("n", "<leader>m", "<cmd>make<Cr>", { silent = false, noremap = true })
  -- set makeprg
  vim.keymap.set("n", "<leader>sm", function()
    local input = util.query_input("Set makeprg: ")
    if input == nil or input == "" then return end
    vim.opt.makeprg = input
  end, { silent = false, noremap = true })

  vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true })
end
return M

local M = {}

function M.setup()
  vim.keymap.set("n", "<space>", "<nop>", { noremap = true })
  vim.g.mapleader = " "
  -- vim.cmd("let mapleader=\"\\<Space>\"")

  -- remap esc to jk
  vim.keymap.set("i", "jk", "<esc>", { noremap = true })
  vim.keymap.set("i", "<esc>", "<nop>", { noremap = true })

  -- move text
  vim.keymap.set("n", "L", ">>", { noremap = true })
  vim.keymap.set("n", "H", "<<", { noremap = true })
  vim.keymap.set("x", "L", ">`[V`]", { noremap = true })
  vim.keymap.set("x", "H", "<`[V`]", { noremap = true })
  vim.keymap.set("x", "J", "dp`[V`]", { noremap = true })
  vim.keymap.set("x", "K", "dkP`[V`]", { noremap = true })

  -- copy to clipboard
  vim.keymap.set("n", "<leader>c", '"+yy', { noremap = true })
  vim.keymap.set("x", "<leader>c", '"+y', { noremap = true })
  vim.keymap.set("n", "<leader>v", '"+p', { noremap = true })

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
end
return M

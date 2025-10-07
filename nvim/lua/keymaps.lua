-- keybinds
vim.keymap.set("i", "jk", "<esc>", { noremap = true })

vim.keymap.set("n", "<leader>y", '"+yy', { noremap = true })
vim.keymap.set("x", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true })

-- dont store {} on jumplist because i dont wanna
vim.keymap.set("n", "}", '<cmd>execute "keepjumps norm! " . v:count1 . "}"<cr>', { noremap = true })
vim.keymap.set("n", "{", '<cmd>execute "keepjumps norm! " . v:count1 . "{"<cr>', { noremap = true })

vim.keymap.set("n", "<C-w>z", "<C-w>|")

vim.keymap.set("n", "<leader>qq", "<cmd>bd<Cr>", { silent = true, noremap = true })

vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true, desc = "Fix last spelling error" })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })
vim.keymap.set('n', '<leader>m', '<cmd>make<CR>', { desc = 'Make' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- use leader + j/k for changing buffers
vim.keymap.set('n', '<leader>j', '<cmd>bn<CR>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '<leader>k', '<cmd>bp<CR>', { desc = 'Go to previous buffer' })

-- resize windows
vim.keymap.set('n', '<C-RIGHT>', '<C-w>>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-LEFT>', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-UP>', '<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-DOWN>', '<C-w>-', { desc = 'Decrease window height' })

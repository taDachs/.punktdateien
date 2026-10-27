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

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })
vim.keymap.set("n", "<leader>m", "<cmd>make<CR>", { desc = "Make" })

-- resize windows
vim.keymap.set("n", "<C-RIGHT>", "<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-LEFT>", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-UP>", "<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<C-DOWN>", "<C-w>-", { desc = "Decrease window height" })

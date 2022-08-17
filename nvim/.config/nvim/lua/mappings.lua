
vim.g.mapleader = '-'

-- remap esc to jk
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('i', '<esc>', '<nop>', { noremap = true })

-- move text
vim.api.nvim_set_keymap('n', 'L', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', 'H', '<<', { noremap = true })
vim.api.nvim_set_keymap('v', 'L', '>`[V`]', { noremap = true })
vim.api.nvim_set_keymap('v', 'H', '<`[V`]', { noremap = true })
vim.api.nvim_set_keymap('v', 'J', 'dp`[V`]', { noremap = true })
vim.api.nvim_set_keymap('v', 'K', 'dkP`[V`]', { noremap = true })

-- copy to clipboard
vim.api.nvim_set_keymap('n', '<leader>c', '"+yy', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>c', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>v', '"+p', { noremap = true })

-- dont store {} on jumplist because i dont wanna
vim.api.nvim_set_keymap('n', '}', '<cmd>execute "keepjumps norm! " . v:count1 . "}"<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '{', '<cmd>execute "keepjumps norm! " . v:count1 . "{"<cr>', { noremap = true })

-- remove highlights
vim.api.nvim_set_keymap('n', '<leader><space>', '<cmd>noh<cr>', { noremap = true })

-- J deletes leading spaces
-- vim.api.nvim_set_keymap('n', 'J', 'Jdw', { noremap = true })

-- tree
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>NvimTreeFindFileToggle<cr>', { noremap = true })


-- comments
vim.keymap.set('n', '<C-_>', '<CMD>lua require("Comment.api").toggle.current_linewise()<CR>')
vim.keymap.set('x', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle.linewise_op(vim.fn.visualmode())<CR>')

-- telescope
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>Telescope ros ros<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', { noremap = true })

-- LSP
-- gd : goto definition
vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { silent = true, noremap = true })
-- gD : goto declaration
vim.api.nvim_set_keymap('n', 'gD', '<cmd>Telescope lsp_declarations<CR>', { silent = true, noremap = true })
-- gr : goto references
vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', { silent = true, noremap = true })
-- gi : goto implementation
vim.api.nvim_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { silent = true, noremap = true })
-- K : show help
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true, noremap = true })
-- g? : show diagnostic
vim.api.nvim_set_keymap('n', 'g?', '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>',
{ silent = true, noremap = true })
-- <C-k> : help with signature
vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true, noremap = true })
-- <C-n> : go to previous
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true, noremap = true })
-- <C-P> : go to next
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true, noremap = true })
-- Shift+F6 : rename
vim.api.nvim_set_keymap('n', '<S-F6>', ':IncRename <C-r>=expand("<cword>")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F18>', ':IncRename <C-r>=expand("<cword>")<CR>', { noremap = true })
-- Alt+Enter : code action
vim.api.nvim_set_keymap('n', '<A-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true, noremap = true })

-- LuaSnip
vim.api.nvim_set_keymap('i', '<Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
{ silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('s', '<Tab>', "<cmd>lua require'luasnip'.jump(1)<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true, noremap = true })

-- bufferline
vim.api.nvim_set_keymap('n', 'gt', "<cmd>BufferLineCycleNext<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gT', "<cmd>BufferLineCyclePrev<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', "<cmd>bd<Cr>", { silent = true, noremap = true })

-- Commands
vim.api.nvim_create_user_command("EditConfig", "tabnew " .. vim.fn.expand("~") .. "/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("EditPlugins", "tabnew " .. vim.fn.expand("~") .. "/.config/nvim/lua/plugins.lua", {})
vim.api.nvim_create_user_command("EditMappings", "tabnew " .. vim.fn.expand("~") .. "/.config/nvim/lua/mappings.lua", {})

vim.api.nvim_create_user_command("FormatBuffer", "lua vim.lsp.buf.format()", {})

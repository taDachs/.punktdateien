vim.api.nvim_set_keymap('n', '<space>', '<nop>', { noremap = true })
vim.g.mapleader = ' '
-- vim.cmd("let mapleader=\"\\<Space>\"")

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

-- <leader>rw -- remove wrapping function call
vim.api.nvim_set_keymap('n', '<leader>rw', 'dt(ds(', { noremap = false })


-- comments
local comment_api = require("Comment.api")
local esc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
)
vim.keymap.set('n', '<leader>co', comment_api.toggle.linewise.current)
vim.keymap.set('x', '<leader>co', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  comment_api.toggle.linewise(vim.fn.visualmode())
end)

-- telescope
vim.api.nvim_set_keymap('n', '<leader>ta', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tr', '<cmd>Telescope ros ros<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tb', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tds', '<cmd>Telescope lsp_document_symbols<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tws', '<cmd>Telescope lsp_workspace_symbols<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tl', '<cmd>Telescope bibtex format=tex<cr><esc>', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-c>', '<cmd>Telescope bibtex format=tex<cr>', { noremap = true })

-- tree
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>NvimTreeFindFileToggle<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>NnnPicker<cr>', { noremap = true })

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
vim.api.nvim_set_keymap('n', 'g?', '<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>', { silent = true, noremap = true })
-- <C-b> : help with signature
vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true, noremap = true })
-- <C-n> : go to previous
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true, noremap = true })
-- <C-P> : go to next
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true, noremap = true })
-- leader rn : rename
vim.api.nvim_set_keymap('n', '<leader>rn', ':IncRename <C-r>=expand("<cword>")<CR>', { noremap = true })
-- leader ca : code action
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true, noremap = true })

-- LuaSnip
vim.api.nvim_set_keymap('i', '<Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('s', '<Tab>', "<cmd>lua require'luasnip'.jump(1)<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true, noremap = true })

-- bufferline
-- vim.api.nvim_set_keymap('n', 'gt', "<cmd>BufferLineCycleNext<Cr>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', 'gT', "<cmd>BufferLineCyclePrev<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', "<cmd>BufferLineCycleNext<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', "<cmd>BufferLineCyclePrev<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>K', "<cmd>BufferLineMoveNext<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>J', "<cmd>BufferLineMovePrev<Cr>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>bls', "lua require('bufferline').sort_buffers_by(function (buf_a, buf_b) return buf_a.name < buf_b.name end)", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', "<cmd>bd<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>1', "<cmd>BufferLineGoToBuffer 1<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>2', "<cmd>BufferLineGoToBuffer 2<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>3', "<cmd>BufferLineGoToBuffer 3<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>4', "<cmd>BufferLineGoToBuffer 4<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>5', "<cmd>BufferLineGoToBuffer 5<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>6', "<cmd>BufferLineGoToBuffer 6<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>7', "<cmd>BufferLineGoToBuffer 7<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>8', "<cmd>BufferLineGoToBuffer 8<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>9', "<cmd>BufferLineGoToBuffer 9<Cr>", { silent = true, noremap = true })

-- Commands
vim.api.nvim_create_user_command("EditConfig", "tabnew " .. vim.fn.expand("~") .. "/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("EditPlugins", "tabnew " .. vim.fn.expand("~") .. "/.config/nvim/lua/plugins.lua", {})
vim.api.nvim_create_user_command("EditMappings", "tabnew " .. vim.fn.expand("~") .. "/.config/nvim/lua/mappings.lua", {})

vim.api.nvim_create_user_command("FormatBuffer", "lua vim.lsp.buf.format()", {})


-- ros helper stuff
vim.api.nvim_set_keymap('v', '<leader>rol', "<cmd>lua open_ros_launch_include()<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rol', "<cmd>lua open_ros_launch_include()<Cr>", { silent = true, noremap = true })

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

-- remove highlights
vim.keymap.set("n", "<leader><space>", "<cmd>noh<cr>", { noremap = true })

-- J deletes leading spaces
-- vim.api.nvim_set_keymap('n', 'J', 'Jdw', { noremap = true })

-- <leader>rw -- remove wrapping function call
vim.keymap.set("n", "<leader>rw", "dt(ds(", { remap = true })

-- comments
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
vim.keymap.set("n", "<leader>co", require("Comment.api").toggle.linewise.current)
vim.keymap.set("x", "<leader>co", function()
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end)

-- telescope
vim.keymap.set("n", "<leader>ta", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tf", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tr", "<cmd>Telescope ros ros<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tds", "<cmd>Telescope lsp_document_symbols<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tws", "<cmd>Telescope lsp_workspace_symbols<cr>", { noremap = true })
vim.keymap.set("n", "gpd", require("goto-preview").goto_preview_definition, { desc = "Opens definition preview" })
vim.keymap.set("n", "gpc", require("goto-preview").close_all_win, { desc = "Opens definition preview" })

-- tree
-- vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>NvimTreeFindFileToggle<cr>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>NnnPicker<cr>', { noremap = true })

-- LSP
-- gd : goto definition
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { silent = true, noremap = true })
-- gD : goto declaration
vim.keymap.set("n", "gD", "<cmd>Telescope lsp_declarations<CR>", { silent = true, noremap = true })
-- gr : goto references
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { silent = true, noremap = true })
-- gi : goto implementation
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { silent = true, noremap = true })
-- K : show help
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true, noremap = true })
-- g? : show diagnostic
vim.keymap.set(
  "n",
  "g?",
  "<cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>",
  { silent = true, noremap = true }
)
vim.keymap.set("n", "gl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
-- <C-b> : help with signature
vim.keymap.set("n", "<C-b>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true, noremap = true })
-- <C-n> : go to previous
vim.keymap.set("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true, noremap = true })
-- <C-P> : go to next
vim.keymap.set("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true, noremap = true })
-- leader rn : rename
vim.keymap.set("n", "<leader>rn", ':IncRename <C-r>=expand("<cword>")<CR>', { noremap = true })
-- leader ca : code action
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true, noremap = true })
-- symbols outline
vim.keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<Cr>", { silent = true, noremap = true })
-- open trouble.nvim
vim.keymap.set("n", "<leader>st", "<cmd>TroubleToggle<Cr>", { silent = true, noremap = true })

-- LuaSnip
vim.api.nvim_set_keymap(
  "i",
  "<Tab>",
  "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
  { silent = true, expr = true }
)
vim.api.nvim_set_keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<Cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>", { silent = true, noremap = true })

-- bufferline
-- vim.api.nvim_set_keymap('n', 'gt', "<cmd>BufferLineCycleNext<Cr>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', 'gT', "<cmd>BufferLineCyclePrev<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>k", "<cmd>BufferLineCycleNext<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>j", "<cmd>BufferLineCyclePrev<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>K", "<cmd>BufferLineMoveNext<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>J", "<cmd>BufferLineMovePrev<Cr>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>bls', "lua require('bufferline').sort_buffers_by(function (buf_a, buf_b) return buf_a.name < buf_b.name end)", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>q", "<cmd>bd<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<Cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<Cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<C-w>z", "<C-w>|")

-- structural replacement
vim.keymap.set({ "n", "x" }, "<leader>sr", function()
  require("ssr").open()
end)

-- vimux
vim.keymap.set({ "n" }, "<leader>tmc", function()
  local _, val = pcall(function()
    return vim.fn.input "Run Command: "
  end)
  if val == "Keyboard interrupt" then
    return
  end
  vim.cmd('VimuxRunCommand "' .. val .. '"')
end)
vim.keymap.set({ "n" }, "<leader>tmr", function()
  vim.cmd "VimuxRunLastCommand"
end)

-- Commands
vim.api.nvim_create_user_command("EditConfig", "tabnew " .. vim.fn.expand "~" .. "/.config/nvim/init.lua", {})
vim.api.nvim_create_user_command("EditPlugins", "tabnew " .. vim.fn.expand "~" .. "/.config/nvim/lua/plugins.lua", {})
vim.api.nvim_create_user_command("EditMappings", "tabnew " .. vim.fn.expand "~" .. "/.config/nvim/lua/mappings.lua", {})

vim.api.nvim_create_user_command("FormatBuffer", "lua vim.lsp.buf.format()", {})

-- ros helper stuff
vim.keymap.set("n", "<leader>rol", function()
  require("ros-nvim.ros").open_launch_include()
end, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>rdm", function()
  require("ros-nvim.ros").show_message_definition()
end, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>rds", function()
  require("ros-nvim.ros").show_service_definition()
end, { silent = true, noremap = true })

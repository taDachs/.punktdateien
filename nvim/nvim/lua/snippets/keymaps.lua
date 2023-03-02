local M = {}

function M.setup()
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
end

return M


local M = {}

M.dependencies = {
	{
		"lervag/vimtex",
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
		ft = { "tex" },
		lazy = false,
	},
	{
		"tadachs/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		config = function()
			require("luasnip-latex-snippets").setup()
		end,
		ft = { "tex", "markdown" },
		lazy = false,
		dev = true,
	},
	{
    "vim-pandoc/vim-pandoc",
    dependencies = { "vim-pandoc/vim-pandoc-syntax" }
  },
}

return M

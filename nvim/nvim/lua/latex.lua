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
			require("luasnip-latex-snippets").setup({ use_treesitter = true })
		end,
		ft = { "tex", "markdown" },
		lazy = false,
		dev = true,
	},
	{
    "vim-pandoc/vim-pandoc",
    dependencies = { "vim-pandoc/vim-pandoc-syntax" },
    config = function()
      vim.cmd([[let g:pandoc#command#autoexec_command="Pandoc pdf --pdf-engine=pdflatex"]])
      vim.cmd([[let g:pandoc#command#autoexec_on_writes=1]])
    end
  },
}

return M

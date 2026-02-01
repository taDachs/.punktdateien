vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black", timeout_ms=5000 },
    cpp = { "clang-format" , lsp_format = "last" },
    rust = { "rustfmt", lsp_format = "last" },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

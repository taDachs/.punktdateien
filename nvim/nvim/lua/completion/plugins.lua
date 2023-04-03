local M = {}

M.dependencies = {
  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "lukas-reineke/cmp-under-comparator",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-emoji",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
    },
    dev = true,
  },
}

return M

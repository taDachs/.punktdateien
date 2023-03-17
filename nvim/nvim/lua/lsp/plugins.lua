local M = {}

M.dependencies = {
  {
    "williamboman/mason-lspconfig.nvim",
    config = true,
    opts = {

      automatic_installation = true,
    },
  },
  { "neovim/nvim-lspconfig" },
  {
    "ray-x/lsp_signature.nvim",
    config = true,
    opts = {
      hint_prefix = ""
    }
  },
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = true,
  },
  {
    "folke/lsp-colors.nvim",
    config = true,
  },
  {
    "folke/trouble.nvim",
    config = true,
  },
  {
    "folke/neodev.nvim",
    config = true,
  },
  "nvim-telescope/telescope.nvim",
  {
    "smjonas/inc-rename.nvim",
    config = true,
    cmd = "IncRename",
  },
  {
    "j-hui/fidget.nvim",
    config = true,
  },
}

return M

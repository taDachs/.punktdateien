local M = {}

M.dependencies = {
  { "onsails/lspkind.nvim" },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function() require("mason-lspconfig").setup({
      automatic_installation = true,
    })
  end,
},
{ "neovim/nvim-lspconfig" },
{
  "ray-x/lsp_signature.nvim",
  config = function() require("lsp_signature").setup({ hint_prefix = "" }) end,
},
{
  "williamboman/mason.nvim",
  config = function() require("mason").setup() end,
},
{ url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = function() require("lsp_lines").setup() end },
{ "folke/lsp-colors.nvim", config = function() require("lsp-colors").setup() end },
{ "folke/trouble.nvim", config = function() require("trouble").setup() end  },
{ "folke/neodev.nvim", config = function() require("neodev").setup() end  },
{ "nvim-telescope/telescope.nvim" },
{
  "smjonas/inc-rename.nvim",
  config = function() require("inc_rename").setup() end,
  cmd = "IncRename",
},
    {
      "j-hui/fidget.nvim",
      config = function() require("fidget").setup() end,
    },
  }

  return M

local M = {}

M.dependencies = {
  {
    "williamboman/mason-lspconfig.nvim",
    config = true,
    opts = {
      automatic_installation = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pylsp.setup {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = { "E203", "W503", "E701" },
                maxLineLength = 100,
              },
            },
          },
        },
      }
      -- require("lspconfig").pyright.setup {}
      require("lspconfig").lua_ls.setup {}
      require("lspconfig").clangd.setup {}
      require("lspconfig").texlab.setup {}
      require("lspconfig").gopls.setup {}
      require("lspconfig").rust_analyzer.setup {}
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = true,
    opts = {
      hint_prefix = "",
      bind = true,
      handler_opts = {
        border = "none",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "folke/lsp-colors.nvim",
    config = true,
  },
  {
    "folke/trouble.nvim",
    config = true,
    keys = {
      {
        "<leader>st",
        function()
          -- vim.diagnostic.setqflist({ open=false })
          vim.cmd "TroubleToggle"
        end,
        mode = "n",
        noremap = true,
        silent = true,
      },
    },
  },
  {
    "folke/neodev.nvim",
    opts = {},
    config = true,
  },
  {
    "smjonas/inc-rename.nvim",
    config = true,
    cmd = "IncRename",
    keys = {
      { "<leader>rn", ':IncRename <C-r>=expand("<cword>")<CR>', mode = "n", noremap = true },
    },
  },
  {
    "j-hui/fidget.nvim",
    config = true,
    tag = "legacy",
  },
}

function M.setup_keymaps()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      -- LSP
      -- gd : goto definition
      vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = args.buf, silent = true, noremap = true })
      -- gD : goto declaration
      vim.keymap.set("n", "gD", require("telescope.builtin").lsp_type_definitions, { buffer = args.buf, silent = true, noremap = true })
      -- gr : goto references
      vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = args.buf, silent = true, noremap = true })
      -- gi : goto implementation
      vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, { buffer = args.buf, silent = true, noremap = true })
      -- K : show help
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf, silent = true, noremap = true })
      -- g? : show diagnostic
      vim.keymap.set("n", "g?", vim.diagnostic.open_float, { buffer = args.buf, silent = true, noremap = true })
      -- <C-b> : help with signature
      vim.keymap.set("i", "<C-b>", vim.lsp.buf.signature_help, { buffer = args.buf, silent = true, noremap = true })
      -- <C-n> : go to previous
      vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, { buffer = args.buf, silent = true, noremap = true })
      -- <C-P> : go to next
      vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, { buffer = args.buf, silent = true, noremap = true })
      -- leader ca : code action
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, silent = true, noremap = true })
    end,
  })
end

function M.setup_commands()
  vim.api.nvim_create_user_command("FormatBuffer", function()
    vim.lsp.buf.format()
  end, {})
end

function M.setup()
  vim.diagnostic.config {
    virtual_text = false,
    severity_sort = true,
  }

  -- require("mason-lspconfig").setup_handlers {
  --   function(server_name) -- default handler (optional)
  --     require("lspconfig")[server_name].setup { autostart = true }
  --   end,
  -- }

  -- keymaps.setup()
  M.setup_keymaps()

  M.setup_commands()
end

return M

local M = {}

function M.setup()
  vim.diagnostic.config {
    virtual_text = false,
  }

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
  -- require("mason-lspconfig").setup_handlers {
  --   function(server_name) -- default handler (optional)
  --     require("lspconfig")[server_name].setup { autostart = true }
  --   end,
  -- }
end

return M

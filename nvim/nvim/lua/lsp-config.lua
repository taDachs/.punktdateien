vim.diagnostic.config {
  virtual_text = false,
}

require("lspconfig").pylsp.setup {}
-- require("lspconfig").clangd.setup {cmd = {"clangd", "-I", "../../include/common/*"}}
require("mason-lspconfig").setup_handlers {
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup { autostart = true }
  end,
}

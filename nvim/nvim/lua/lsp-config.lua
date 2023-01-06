-- local lsp_installer = require("nvim-lsp-installer")
--
-- lsp_installer.on_server_ready(function(server)
--   local opts = {}
--   server:setup(opts)
-- end)

vim.diagnostic.config({
  virtual_text = false
})

require("lspconfig").pylsp.setup {}
-- require("lspconfig").clangd.setup {cmd = {"clangd", "-I", "../../include/common/*"}}
require("mason-lspconfig").setup_handlers({
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
})

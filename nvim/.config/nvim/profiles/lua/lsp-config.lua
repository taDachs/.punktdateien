-- python
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pylsp.setup {
  capabilities = capabilities
}
require('lspconfig').pyright.setup({
  capabilities = capabilities
})

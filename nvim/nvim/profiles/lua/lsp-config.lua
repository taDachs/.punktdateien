-- python
 --Setup lspconfig.
local pylsp_cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pylsp.setup {
  capabilities = pylsp_cap,
}

require('lspconfig').clangd.setup({})

require('lspconfig').texlab.setup({})


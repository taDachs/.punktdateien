-- python
 --Setup lspconfig.
local pylsp_cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pylsp.setup {
  capabilities = pylsp_cap,
}

local pyright_cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').pyright.setup({
  on_attach = function(client)
    client.resolved_capabilities.rename = false
  end,
  capabilities = pyright_cap,
})

require('lspconfig').clangd.setup({})

require('lspconfig').texlab.setup({})


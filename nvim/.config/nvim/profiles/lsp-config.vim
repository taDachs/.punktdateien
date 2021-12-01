" gd : goto definition
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" gD : goto declaration
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" gr : goto references
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" gi : goto implementation
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" K : show help
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" <C-k> : help with signature
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" <C-n> : go to previous
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" <C-P> : go to next
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

luafile ~/.config/nvim/profiles/lua/lsp-config.lua

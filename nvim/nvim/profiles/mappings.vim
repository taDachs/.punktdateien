let g:mapleader = '-'

function! ToggleNERDTreeFind()
    if g:NERDTree.IsOpen()
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
endfunction
nnoremap <leader>a <cmd>call ToggleNERDTreeFind()<cr>

nnoremap <leader><C-a> <cmd>Telescope find_files<cr>
nnoremap <leader><C-f> <cmd>Telescope live_grep<cr>

map <C-_> <plug>NERDCommenterToggle

noremap L >>
noremap H <<
inoremap jk <Esc>
inoremap <Esc> <nop>

" LSP
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
" Shift+F6 : rename
nnoremap <silent> <F18> <cmd>lua vim.lsp.buf.rename()<CR>
" Shift+F6 : rename
nnoremap <silent> <a-CR> <cmd>lua vim.lsp.buf.code_action()<CR>

" UltiSnips
" Move to next Tab Stop
let g:UltiSnipsJumpForwardTrigger="<c-b>"
" Move to previous Tab Stop
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

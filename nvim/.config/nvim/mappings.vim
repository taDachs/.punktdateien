let g:mapleader = '-'

function! ToggleNERDTreeFind()
    if g:NERDTree.IsOpen()
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
endfunction

fun OpenTerminalSplit()
  exec "split term://zsh"
  wincmd J
  exec "resize ".winheight(0)/3
  normal A
endf

nnoremap <leader>a <cmd>call ToggleNERDTreeFind()<cr>

nnoremap <leader><C-a> <cmd>Telescope find_files<cr>
nnoremap <leader><C-f> <cmd>Telescope live_grep<cr>

nnoremap <leader><C-t> <cmd>call OpenTerminalSplit()<cr>

" x clipboard mappings
nnoremap <leader>c "+yy
vnoremap <leader>c "+y
nnoremap <leader>v "+p

" toggle numbers
nnoremap <leader>n <cmd>set nu!<cr><cmd>set rnu!<cr>

map <C-_> <plug>NERDCommenterToggle

nnoremap L >>
nnoremap H <<
inoremap jk <Esc>
inoremap <Esc> <nop>
tnoremap jk <C-\><C-n>

" nnoremap <C-l> <cmd>wincmd l<cr>
" nnoremap <C-h> <cmd>wincmd h<cr>
" nnoremap <C-j> <cmd>wincmd j<cr>
" nnoremap <C-k> <cmd>wincmd k<cr>


" dont store {} on jumplist because i dont wanna
nnoremap } <cmd>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap { <cmd>execute "keepjumps norm! " . v:count1 . "{"<CR>

nnoremap <leader><space> <cmd>noh<cr>

command EditConfig :tabnew ~/.config/nvim/init.vim
command EditPlugins :tabnew ~/.config/nvim/plugins.vim
command EditMappings :tabnew ~/.config/nvim/mappings.vim
command EditSnippets :tabnew ~/Projects/musnips/UltiSnips/python.snippets

" LSP
" gd : goto definition
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" gD : goto declaration
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" gr : goto references
nnoremap <silent> gr <cmd>Telescope lsp_references<CR>
" gi : goto implementation
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" K : show help
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
" g? : show diagnostic
nnoremap <silent> g? <cmd>lua vim.diagnostic.open_float(nil, {focus=false})<CR>
" <C-k> : help with signature
nnoremap <silent> <C-b> <cmd>lua vim.lsp.buf.signature_help()<CR>
" <C-n> : go to previous
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_prev()<CR>
" <C-P> : go to next
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_next()<CR>
" Shift+F6 : rename
nnoremap <silent> <S-F6> <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <F18> <cmd>lua vim.lsp.buf.rename()<CR>
" Alt+Enter : code action
nnoremap <silent> <A-CR> <cmd>lua vim.lsp.buf.code_action()<CR>


" UltiSnips
" Move to next Tab Stop
let g:UltiSnipsJumpForwardTrigger="<c-n>"
" Move to previous Tab Stop
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsExpandTrigger="<>"

" PydocString
nmap <silent> <nop> <Plug>(pydocstring)

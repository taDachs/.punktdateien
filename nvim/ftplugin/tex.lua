-- Scoped deliberately: `vim.opt` here would set these globally and leak into
-- every other buffer. 'textwidth' is buffer-local; 'spell' and the fold options
-- are window-local, so the vim.wo[0][0] form ties them to this buffer.
vim.bo.textwidth = 100
vim.wo[0][0].spell = true

-- NOTE: nvim-treesitter overwrites 'foldmethod'/'foldexpr' for tex after this
-- ftplugin runs (see lua/plugins/treesitter.lua). Kept so vimtex folding is
-- restored if treesitter ever stops handling tex.
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "vimtex#fold#level(v:lnum)"
vim.wo[0][0].foldtext = "vimtex#fold#text()"

vim.g.vimtex_view_method = "zathura"

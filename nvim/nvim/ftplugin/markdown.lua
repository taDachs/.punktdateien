vim.opt.spell = true

vim.opt.textwidth = 100

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()

-- zettelkasten specific stuff
local zettel_group = vim.api.nvim_create_augroup("Zettelkasten", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
  pattern = vim.fn.expand "~" .. "/notes/zettelkasten/*.md",
  callback = function()
    local zettel = require "zettel"
    vim.keymap.set("n", "<CR>", zettel.follow_link_under_cursor, { buffer = true })
    vim.keymap.set("i", "<c-]>", zettel.insert_new_link, { buffer = true })
    vim.keymap.set("v", "<c-]>", function()
      vim.cmd.normal [["zd]]
      zettel.insert_new_link()
      vim.cmd.normal [[F[di["zPf]f)]]
    end, { buffer = true })
    vim.keymap.set("n", "<leader>ti", "<cmd>Telescope zettel find_incoming<CR>", { buffer = true })
    vim.keymap.set("n", "<leader>to", "<cmd>Telescope zettel find_outgoing<CR>", { buffer = true })
    vim.keymap.set("n", "<leader>tza", "<cmd>Telescope zettel find_all<CR>", { buffer = true })
    vim.keymap.set("n", "<leader>tt", "<cmd>Telescope zettel tag<CR>", { buffer = true })
    vim.keymap.set("i", "<c-[>", "<cmd>Telescope zettel insert_link<CR>", { buffer = true })
  end,
  group = zettel_group,
})

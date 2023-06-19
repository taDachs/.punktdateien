vim.opt.spell = true

-- zettelkasten specific stuff
local zettel_group = vim.api.nvim_create_augroup("Zettelkasten", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufRead", "BufNewFile" }, {
  pattern = vim.fn.expand("~") .. "/notes/zettelkasten/*.md",
  callback = function()
    local zettelkasten = require "zettelkasten"
    zettelkasten.setup {
      root_dir = "~/notes/zettelkasten",
    }
    vim.keymap.set("n", "<CR>", zettelkasten.follow_link_under_cursor, { buffer = true })
    vim.keymap.set("i", "<c-]>", zettelkasten.insert_new_link, { buffer = true })
    vim.keymap.set("n", "<leader>ti", function() zettelkasten.pickers.zettel_picker(nil, "incoming", "open") end,
      { buffer = true })
    vim.keymap.set("n", "<leader>to", function() zettelkasten.pickers.zettel_picker(nil, "outgoing", "open") end,
      { buffer = true })
    vim.keymap.set("n", "<leader>ta", function() zettelkasten.pickers.zettel_picker(nil, "all", "open") end,
      { buffer = true })
    vim.keymap.set("i", "<c-[>", function() zettelkasten.pickers.zettel_picker(nil, "all", "insert") end,
      { buffer = true })
  end,
  group = zettel_group,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = vim.fn.expand("~") .. "/notes/zettelkasten/*.md",
  callback = function()
    local zettelkasten = require "zettelkasten"
    local current_file_path = vim.api.nvim_buf_get_name(0)
    zettelkasten.graph:addFromPath(current_file_path)
  end,
  group = zettel_group,
})

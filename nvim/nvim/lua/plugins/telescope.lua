local M = {}

function M.setup()
  require("telescope").setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      },
    },
  }
end

return M

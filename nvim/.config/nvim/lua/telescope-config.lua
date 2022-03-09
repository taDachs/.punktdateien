local actions = require("telescope.actions")
local action_state = require "telescope.actions.state"
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require("telescope.config").values

require('telescope').setup{
  defaults = {
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '--iglob', '!.git'},
      mappings = {
        i = {
          ["<C-a>"] = actions.close
        },
        n = {
          ["<C-a>"] = actions.close
        }
      },
    },
    live_grep = {
      mappings = {
        i = {
          ["<C-f>"] = actions.close
        },
        n = {
          ["<C-f>"] = actions.close
        }
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
  }
}



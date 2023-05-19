M = {}

M.colors = {
  background_color = { "#000000", "#050505", "#111111", "#222222", "#333333", "#444444" },
  foreground_color = { "#ffffff", "#dddddd", "#bbbbbb", "#999999", "#777777", "#555555" },
  kit_exclusive_green = { "#00a88f", "#00bca9", "#72ccbf", "#acdfd6", "#d4ede9" },
  kit_exclusive_blue = { "#2075b8", "#6f93c8", "#94acd5", "#bbc8e4", "#dbe3f1" },
  kit_may_green = { "#68c152", "#97d07e", "#b3dba0", "#d0e8c3", "#e6f2df" },
  kit_yellow = { "#ffe844", "#ffef7b", "#fff2a1", "#fff7c5", "#ffeeda" },
  kit_orange = { "#fd9c3a", "#ffb86c", "#ffcb91", "#ffddb8", "#ffddb8", "#ffeeda" },
  kit_brown = { "#b48640", "#c8a36c", "#d5b98e", "#e4d1b6", "#f2e7d7" },
  kit_red = { "#c62033", "#d56959", "#df8f7d", "#ecb8a8", "#f4d9ce" },
  kit_lila = { "#c2028a", "#d067a9", "#db91be", "#e8bad6", "#f2dae9" },
  kit_cyan_blue = { "#00ace6", "#0cbfeb", "#75cef0", "#afe0f5", "#d6eff9" },
}

M.dependencies = {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = true,
    opts = {
      options = {
        icons_enabled = true,
        theme = {
          normal = {
            a = { bg = M.colors.kit_exclusive_green[1], fg = M.colors.background_color[1], gui = "bold" },
            b = { bg = M.colors.background_color[4], fg = M.colors.foreground_color[1] },
            c = { bg = M.colors.background_color[3], fg = M.colors.foreground_color[4] },
          },
          insert = {
            a = { bg = M.colors.kit_orange[1], fg = M.colors.background_color[1], gui = "bold" },
            b = { bg = M.colors.background_color[4], fg = M.colors.foreground_color[1] },
            c = { bg = M.colors.background_color[3], fg = M.colors.foreground_color[4] },
          },
          visual = {
            a = { bg = M.colors.kit_yellow[1], fg = M.colors.background_color[1], gui = "bold" },
            b = { bg = M.colors.background_color[4], fg = M.colors.foreground_color[1] },
            c = { bg = M.colors.background_color[3], fg = M.colors.foreground_color[1] },
          },
          replace = {
            a = { bg = M.colors.kit_red[1], fg = M.colors.background_color[1], gui = "bold" },
            b = { bg = M.colors.background_color[4], fg = M.colors.foreground_color[1] },
            c = { bg = M.colors.background_color[3], fg = M.colors.foreground_color[1] },
          },
          command = {
            a = { bg = M.colors.kit_lila[1], fg = M.colors.background_color[1], gui = "bold" },
            b = { bg = M.colors.background_color[4], fg = M.colors.foreground_color[1] },
            c = { bg = M.colors.background_color[3], fg = M.colors.foreground_color[1] },
          },
          inactive = {
            a = { bg = M.colors.background_color[2], fg = M.colors.foreground_color[2], gui = "bold" },
            b = { bg = M.colors.background_color[4], fg = M.colors.foreground_color[1] },
            c = { bg = M.colors.background_color[3], fg = M.colors.foreground_color[1] },
          },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = {
          function()
            local workspace = require("ros-nvim.ros").handle.env:get_current_ws()
            if workspace == nil then
              return ""
            else
              return workspace
            end
          end,
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = {
          "progress",
          function()
            return vim.fn.line "." .. "/" .. vim.fn.line "$"
          end,
        },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
          "tabs",
          mode = 1, -- 0: Shows tab_nr
          }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          -- { require("nvim-treesitter").statusline(90) }
        },
      },
      extensions = {},
    },
  },

  -- colorschemes
  "phanviet/vim-monokai-pro",
  {
    "tadachs/kit.vim",
    init = function()
      vim.g.kit_italic = 1
      vim.g.kit_bold = 1
    end,
    dev = true,
  },
}

function M.setup()
  vim.cmd.colorscheme "kit"
  vim.cmd([[highlight IndentBlanklineChar guifg=]] .. M.colors.background_color[6] .. [[ gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineSpaceChar guifg=]] .. M.colors.background_color[6] .. [[ gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineContextChar guifg=]] .. M.colors.foreground_color[4] .. [[ gui=nocombine]])
  vim.cmd([[highlight CursorLine guibg=]] .. M.colors.background_color[4])
  vim.cmd([[highlight CursorLineNr guifg=]] .. M.colors.kit_exclusive_green[1])

  vim.opt.cursorline = true
  vim.o.signcolumn = "yes"
end

return M

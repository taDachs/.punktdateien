local colors = require "ui.colors"

local M = {}

local colorscheme = {
  normal = {
    a = { bg = colors.kit_exclusive_green[1], fg = colors.background_color[1], gui = "bold" },
    b = { bg = colors.background_color[4], fg = colors.foreground_color[1] },
    c = { bg = colors.background_color[3], fg = colors.foreground_color[4] },
  },
  insert = {
    a = { bg = colors.kit_orange[1], fg = colors.background_color[1], gui = "bold" },
    b = { bg = colors.background_color[4], fg = colors.foreground_color[1] },
    c = { bg = colors.background_color[3], fg = colors.foreground_color[4] },
  },
  visual = {
    a = { bg = colors.kit_yellow[1], fg = colors.background_color[1], gui = "bold" },
    b = { bg = colors.background_color[4], fg = colors.foreground_color[1] },
    c = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
  },
  replace = {
    a = { bg = colors.kit_red[1], fg = colors.background_color[1], gui = "bold" },
    b = { bg = colors.background_color[4], fg = colors.foreground_color[1] },
    c = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
  },
  command = {
    a = { bg = colors.kit_lila[1], fg = colors.background_color[1], gui = "bold" },
    b = { bg = colors.background_color[4], fg = colors.foreground_color[1] },
    c = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
  },
  inactive = {
    a = { bg = colors.background_color[2], fg = colors.foreground_color[2], gui = "bold" },
    b = { bg = colors.background_color[4], fg = colors.foreground_color[1] },
    c = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
  },
}

function M.setup()
  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = colorscheme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
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
    tabline = {},
    extensions = {},
  }
end

return M

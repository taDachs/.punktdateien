M = {}

local colors = {
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
    enabled=true,
    config = true,
    opts = {
      options = {
        icons_enabled = true,
        -- theme = {
        --   normal = {
        --     a = { bg = colors.kit_exclusive_green[1], fg = colors.background_color[1], gui = "bold" },
        --     b = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
        --     c = { bg = colors.background_color[2], fg = colors.foreground_color[4] },
        --   },
        --   insert = {
        --     a = { bg = colors.kit_orange[1], fg = colors.background_color[1], gui = "bold" },
        --     b = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
        --     c = { bg = colors.background_color[2], fg = colors.foreground_color[4] },
        --   },
        --   visual = {
        --     a = { bg = colors.kit_yellow[1], fg = colors.background_color[1], gui = "bold" },
        --     b = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
        --     c = { bg = colors.background_color[2], fg = colors.foreground_color[1] },
        --   },
        --   replace = {
        --     a = { bg = colors.kit_red[1], fg = colors.background_color[1], gui = "bold" },
        --     b = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
        --     c = { bg = colors.background_color[2], fg = colors.foreground_color[1] },
        --   },
        --   command = {
        --     a = { bg = colors.kit_lila[1], fg = colors.background_color[1], gui = "bold" },
        --     b = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
        --     c = { bg = colors.background_color[2], fg = colors.foreground_color[1] },
        --   },
        --   inactive = {
        --     a = { bg = colors.background_color[2], fg = colors.foreground_color[2], gui = "bold" },
        --     b = { bg = colors.background_color[3], fg = colors.foreground_color[1] },
        --     c = { bg = colors.background_color[2], fg = colors.foreground_color[1] },
        --   },
        -- },
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(s, ctx)
              local symbols = {
                NORMAL = " N ",
                VISUAL = " V ",
                ["V-LINE"] = " V ",
                ["V-BLOCK"] = " V ",
                INSERT = " I ",
                REPLACE = " R ",
              }
              if symbols[s] then
                return symbols[s]
              end
              return s
            end,
          },
        },
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
          "filetype",
          "progress",
        },
        lualine_y = {
          function()
            return vim.fn.line "." .. "/" .. vim.fn.line "$"
          end,
        },
        lualine_z = {},
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
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          "filename",
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          -- { require("nvim-treesitter").statusline(90) },
          {
            "tabs",
            mode = 0, -- 0: Shows tab_nr
          },
        },
      },
      extensions = {},
    },
  },

    -- colorschemes
  "phanviet/vim-monokai-pro",
  "projekt0n/github-nvim-theme",
  "nyoom-engineering/oxocarbon.nvim",
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "tadachs/kit.vim",
    init = function()
      vim.g.kit_italic = 1
      vim.g.kit_bold = 1
    end,
    dev = false,
  },
}

local function detect_color_scheme()
  -- user gsettings get org.gnome.desktop.interface gtk-theme instead, which returns something ending on '-dark' if a dark mode is picked
  local handle = io.popen('gsettings get org.gnome.desktop.interface gtk-theme')

  if handle == nil then
    return "dark"
  end

  local result = handle:read("*a")
  handle:close()

  if string.find(result, "-dark") then
    return "dark"
  else
    return "light"
  end
end

COLOR_MODE = nil

local function set_color_scheme()
  local current_color_mode = detect_color_scheme()

  if COLOR_MODE == nil then
    COLOR_MODE = current_color_mode
  elseif COLOR_MODE == current_color_mode then
    return
  else
    COLOR_MODE = current_color_mode
  end

  if COLOR_MODE == "light" then
    vim.opt.background = "light"
    vim.cmd("colorscheme github_light")
  elseif COLOR_MODE == "dark" then
    vim.opt.background = "dark"
    vim.cmd("colorscheme github_dark_high_contrast")
  end
end

function M.setup()
  set_color_scheme()

  -- Create an autocommand group
  vim.api.nvim_create_augroup("MyUiCommands", { clear = true })

  -- Set up an autocommand that triggers on write to any file
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = "MyUiCommands",
    pattern = "*", -- You can specify a pattern like "*.txt" to limit the files
    callback = function(args)
      set_color_scheme()
    end,
  })

  vim.cmd([[hi! link Conceal Special]])

  vim.opt.cursorline = true
  vim.o.signcolumn = "yes"
  -- vim.o.cmdheight = 0

  if vim.g.neovide then
    vim.o.guifont = "BlexMono Nerd Font:h8"
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0
  end

  -- highlight trailing whitespace
  vim.cmd [[highlight ExtraWhitespace ctermbg=red guibg=red]]
  vim.cmd [[match ExtraWhitespace /\s\+$/]]
end

return M

vim.pack.add({
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/folke/lsp-colors.nvim",
})

local colorscheme = "carbonfox"

require "lsp-colors".setup()
vim.cmd("colorscheme " .. colorscheme)

-- improve cmd message handling if available
local ok, extui = pcall(require, "vim._extui")
if ok and type(extui.enable) == "function" then
  vim.o.cmdheight = 0;
  extui.enable({
    enable = true,
    msg = { -- Options related to the message module.
      ---@type 'cmd'|'msg' Type of window used to place messages, either in the
      ---cmdline or in a separate ephemeral message box window.
      target = 'msg',
      timeout = 4000,
    },
  })
end

-- highlight trailing whitespace
vim.cmd [[match errorMsg /\s\+$/]]

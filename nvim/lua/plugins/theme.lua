local darktheme = "carbonfox"
local lighttheme = "dayfox"

return {
  { "folke/lsp-colors.nvim" },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("lsp-colors").setup()
      vim.cmd("colorscheme " .. darktheme)
      vim.keymap.set("n", "<leader>cc", function()
        if vim.g.colors_name == darktheme then
          vim.cmd("colorscheme " .. lighttheme)
        else
          vim.cmd("colorscheme " .. darktheme)
        end
      end, { desc = "Set darkmode" })
    end,
  },
}

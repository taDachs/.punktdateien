return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim",
    opts = {
      snippetDir = "~/.config/nvim/snippets",
    },
    keys = {
      { "<leader>se", function() require("scissors").editSnippet() end, desc = "[S]nippet [E]dit" },
      { "<leader>sa", function() require("scissors").addNewSnippet() end, desc = "[S]nippet [A]dd", mode = {"n", "x"} },
    }
  },
}

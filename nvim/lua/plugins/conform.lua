return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        cpp = { "clang-format", lsp_format = "fallback" },
        bash = { "beautysh" },
        sh = { "beautysh" },
        zsh = { "beautysh" },
        json = { "jq" },
        jsonc = { "jq" },
      },
      formatters = {
        beautysh = {
          prepend_args = { "--indent-size", "2" },
        },
        isort = {
          prepend_args = { "--profile", "black" },
        },
        black = {
          prepend_args = { "--line-length", "100" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}

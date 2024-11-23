return {
  {
    "tadachs/ros-nvim",
    config = true,
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
    dev = false,
    ft = { "launch", "msg", "srv", "action" },
    lazy = true,
    keys = {
      {
        "<leader>rol",
        function()
          require("ros-nvim.ros").open_launch_include()
        end,
        silent = true,
        noremap = true,
        desc = "[R]os [O]pen [L]aunch file include"
      },
      {
        "<leader>rd",
        function()
          require("ros-nvim.ros").show_interface_definition()
        end,
        silent = true,
        noremap = true,
        desc = "[R]os interface [D]efinition"
      },
    },
  },
}
return {
  {"folke/tokyonight.nvim",
    enabled = false,
    init = function()
        vim.cmd.colorscheme("tokyonight")
    end,
  },

  {"catppuccin/nvim",
    enabled = true,
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
    },
    init = function()
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}

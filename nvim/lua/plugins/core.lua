return {
  { "ellisonleao/gruvbox.nvim" },
  { "EdenEast/nightfox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",

      news = {
        -- When enabled, NEWS.md will be shown when changed.
        -- This only contains big new features and breaking changes.
        lazyvim = false,
        -- Same but for Neovim's news.txt
        neovim = false,
      },
    },
  },
  {
    "xymeng16/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      startify = require("alpha.themes.startify").config
      require("alpha").setup(startify)
    end,
  },
}

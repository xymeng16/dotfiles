return {
  "HUAHUAI23/nvim-quietlight",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })
  end,
}

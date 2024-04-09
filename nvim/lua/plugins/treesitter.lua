if true then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      c = {
        ensure_installed = {
          "c",
          "go",
          "gomod",
          "gowork",
          "gosum",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      }
      configs.setup(c)
      if vim.fn.has("win32") == 1 then
        c.compilers = { "clang" }
      end
    end,
  },
  {
    "nvim-treesitter/playground",
  },
}

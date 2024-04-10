return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- remap some key bindings to fzf-lua
    { "<leader>/", "<cmd>FzfLua live_grep_glob<cr>", desc = "FzfLua Live Grep Glob" },
    { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "FzfLua Files" },
    { "<leader>sb", "<cmd>FzfLua buffers<cr>", desc = "FzfLua Buffers" },
  },
}

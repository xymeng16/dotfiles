return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      debug = true,
      action = {
        ["ctrl-h"] = {
          function(_, args)
            if args.cmd:find("--hidden") then
              args.cmd = args.cmd:gsub("--hidden", "", 1)
            else
              args.cmd = args.cmd .. " --hidden"
            end
            require("fzf-lua").files(args)
          end,
        },
      },
    })
  end,
}

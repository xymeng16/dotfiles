-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- opt.tabstop = 4
-- opt.shiftwidth = 4
-- opt.softtabstop = 4

opt.wrap = true
opt.mouse = ""
if vim.fn.has("win32") == 1 then
  opt.shell = "pwsh.exe" -- Please install Powershell 7
end

-- try mitigating old-school vimrc
vim.api.nvim_command("filetype plugin indent on")
vim.api.nvim_command("syntax on")

vim.g.vimtex_compiler_method = "latexmk"

if vim.fn.has("win32") == 1 or (vim.fn.has("unix") == 1 and os.getenv("WSLENV") == 1) then
  if vim.fn.executable("SumatraPDF.exe") == 1 then
    vim.g.vimtex_view_general_viewer = "SumatraPDF.exe"
  elseif vim.fn.executable("sioyek.exe") == 1 then
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
    vim.g.vimtex_callback_progpath = "wsl nvim"
  elseif vim.fn.executable("mupdf.exe") == 1 then
    vim.g.vimtex_view_general_viewer = "mupdf.exe"
  end
elseif vim.fn.has("osx") == 1 then
  vim.g.vimtex_view_method = "skim"
  vim.g.vimtex_view_skim_sync = 1
  vim.g.vimtex_view_skim_activate = 1
  vim.g.vimtex_view_skim_reading_bar = 1
else
  vim.g.vimtex_view_method = "zathura"
end

function SetServerName()
  if vim.fn.has("win32") == 1 then
    local nvim_server_file = "C:/Users/xiangyi/AppData/Local/Temp" .. "/curnvimserver.txt"
    local cmd = string.format("echo %s > %s", vim.v.servername, nvim_server_file)
    vim.call("system", cmd)
  end
end

local vimtex_common_group = vim.api.nvim_create_augroup("vimtex_common", {})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "tex" },
  callback = SetServerName,
})

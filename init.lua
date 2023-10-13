for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify(
      "Error setting up colorscheme: " .. astronvim.default_colorscheme,
      vim.log.levels.ERROR
    )
  end
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

vim.cmd("source ~/.config/nvim/sops")
-- vim.cmd("source ~/.config/nvim/vault")

vim.cmd([[
  augroup terraformFileType
    autocmd!
    autocmd BufNewFile,BufRead *.tf set filetype=terraform
  augroup END
]])

-- Add an autocmd to detect and set the filetype for ansible files
vim.cmd[[
  autocmd BufRead,BufNewFile **/ansible*/* set filetype=yaml.ansible
]]

vim.g.tabby_server_url = "https://tabby.exsplash.it"

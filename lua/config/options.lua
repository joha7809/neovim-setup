-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Default: use spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Use tabs (not spaces) for specific languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java", "python" }, -- add more if needed
  callback = function()
    vim.opt_local.expandtab = false -- Use tabs
    vim.opt_local.shiftwidth = 4 -- Indent width
    vim.opt_local.tabstop = 4 -- Visual width of a tab
    vim.opt_local.softtabstop = 4 -- Tab insert/delete width
  end,
})

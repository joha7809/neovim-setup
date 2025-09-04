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
    vim.opt_local.expandtab = true -- Use spaces for vscode
    vim.opt_local.shiftwidth = 4 -- Indent width
    vim.opt_local.tabstop = 4 -- Visual width of a tab
    vim.opt_local.softtabstop = 4 -- Tab insert/delete width
  end,
})

-- Disable auto formatting
-- vim.g.autoformat = false

-- ~/.config/nvim/lua/config/options.lua
-- Maybe use basedpyright someday...
vim.g.lazyvim_python_lsp = "pyright" -- use Pyright :contentReference[oaicite:4]{index=4}
vim.g.lazyvim_python_ruff = "ruff_lsp" -- use Ruff as LSP :contentReference[oaicite:5]{index=5}

vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})

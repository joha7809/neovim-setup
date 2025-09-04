-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set("n", "<leader>cd", function()
  for _, id in pairs(vim.api.nvim_get_namespaces()) do
    vim.diagnostic.reset(id, 0)
  end
end, { desc = "Clear diagnostics (all namespaces, current buffer)" })

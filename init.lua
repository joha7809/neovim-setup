-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- mapping to disable completion suggestion on <C-e>
vim.g.completion_enabled = true
-- Toggle completion menu with Ctrl + E
vim.api.nvim_set_keymap(
  "i",
  "<C-e>",
  [[
  if vim.g.completion_enabled then
    require'compe'.close()  -- Close completion menu
    vim.g.completion_enabled = false  -- Disable it
  else
    vim.g.completion_enabled = true  -- Enable it
  end
]],
  { noremap = true, silent = true }
)

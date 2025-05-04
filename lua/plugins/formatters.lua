-- ~/.config/nvim/lua/plugins/formatters.lua
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "autopep8" }, -- Use 'black' to format Python files
      lua = { "stylua" }, -- Use 'stylua' for Lua files
      sh = { "shfmt" }, -- Use 'shfmt' for shell script files
      fish = { "fish_indent" }, -- Use 'fish_indent' for Fish shell scripts
    },
  },
}

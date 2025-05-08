-- ~/.config/nvim/lua/plugins/trouble.lua

return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" }, -- Load Trouble only when this command is executed
    opts = {
      modes = {
        symbols = { -- Configure symbols mode for Trouble
          win = {
            type = "split", -- Open in a split window
            relative = "win", -- Relative to the current window
            position = "left", -- Open on the right side
            size = 0.3, -- Set size of the split (30% of the window)
          },
        },
      },
    },
  },
}

return {
  "zbirenbaum/copilot.lua",
  opts = {},
  keys = {
    {
      "<leader>ac",
      function()
        vim.g.copilot_enabled = not vim.g.copilot_enabled
        if vim.g.copilot_enabled then
          vim.cmd("Copilot enable")
          vim.notify("GitHub Copilot enabled", vim.log.levels.INFO)
        else
          vim.cmd("Copilot disable")
          vim.notify("GitHub Copilot disabled", vim.log.levels.INFO)
        end
      end,
      noremap = true,
      silent = true,
      desc = "Toggle GitHub Copilot",
    },
  },
}

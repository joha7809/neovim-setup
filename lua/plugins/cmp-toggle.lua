return {
  {
    "hrsh7th/nvim-cmp",
    init = function()
      vim.g.cmp_disabled = false
    end,
    opts = function(_, opts)
      opts.enabled = function()
        return not vim.g.cmp_disabled
      end
    end,
    keys = {
      {
        "<leader>at",
        function()
          vim.g.cmp_disabled = not vim.g.cmp_disabled
          local msg = vim.g.cmp_disabled and "Autocompletion (cmp) disabled" or "Autocompletion (cmp) enabled"
          vim.notify(msg, vim.log.levels.INFO)
        end,
        noremap = true,
        silent = true,
        desc = "Toggle autocompletion (nvim-cmp)",
      },
    },
  },

  {
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
  },
}

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
        desc = "Toggle autocompletion",
      },
    },
  },
}

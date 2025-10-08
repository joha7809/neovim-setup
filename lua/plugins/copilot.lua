return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      -- start with copilot enabled by default
      vim.g.copilot_enabled = true
    end,
    opts = {
      -- panel UI disabled by default
      panel = { enabled = true },
      suggestion = {
        auto_trigger = false,
        enabled = true,
        -- use Alt/Meta key mappings for Copilot
        keymap = {
          accept = false, -- disable built-in accept
          accept_word = "<M-w>",
          accept_line = "<M-l>",
          next = "<M-n>",
          prev = "<M-p>",
          dismiss = "/",
        },
      },
    },
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
    config = function(_, opts)
      local cmp = require("cmp")
      local copilot = require("copilot.suggestion")
      local luasnip = require("luasnip")

      -- setup Copilot with our options
      require("copilot").setup(opts)

      -- enable Copilot at startup
      if vim.g.copilot_enabled then
        vim.cmd("Copilot enable")
      end

      -- helper to toggle suggestion triggering

      local function set_trigger(on)
        vim.b.copilot_suggestion_auto_trigger = on
        vim.b.copilot_suggestion_hidden = not on
      end

      -- initially allow suggestions
      set_trigger(false)

      -- -- hide Copilot when cmp menu opens
      -- cmp.event:on("menu_opened", function()
      --   if copilot.is_visible() then
      --     copilot.dismiss()
      --   end
      --   set_trigger(false)
      -- end)
      --
      -- -- re-enable Copilot after cmp menu closes
      -- cmp.event:on("menu_closed", function()
      --   set_trigger(not luasnip.expand_or_locally_jumpable())
      -- end)

      -- disable Copilot inside snippets
      vim.api.nvim_create_autocmd("User", {
        pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
        callback = function()
          set_trigger(not luasnip.expand_or_locally_jumpable())
        end,
      })
    end,
  },
}

return {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<leader>ft",
      function()
        local root = require("lazyvim.util").root()
        local snacks = require("snacks")

        -- Look for venv in root
        local function find_local_venv()
          local paths = { ".venv", "venv" }
          for _, name in ipairs(paths) do
            local full = root .. "/" .. name
            if vim.fn.isdirectory(full) == 1 then
              return full
            end
          end
          return nil
        end

        local function venv_shell_cmd()
          local venv = find_local_venv() or vim.g.VIRTUAL_ENV
          if venv then
            return string.format("source %s/bin/activate; exec $SHELL", venv)
          else
            return "$SHELL"
          end
        end

        -- Use Snacks.terminal instead of LazyVim.terminal
        snacks.terminal(nil, {
          cwd = root,
          cmd = venv_shell_cmd(),
        })
      end,
      desc = "Terminal (Root Dir + venv)",
    },
  },
}

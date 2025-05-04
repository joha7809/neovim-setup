-- ~/.config/nvim/lua/plugins/linter.lua

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Dynamically resolve mypy from the activated virtual environment
    lint.linters.mypy.cmd = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        local mypy_path = venv .. "/bin/mypy"
        if vim.fn.filereadable(mypy_path) == 1 then
          return mypy_path
        else
          print("Warning: mypy not found in virtual environment.")
        end
      end
      return "mypy"
    end

    lint.linters_by_ft = {
      python = { "mypy" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

-- ~/.config/nvim/lua/plugins/lint.lua
return {
  "mfussenegger/nvim-lint",
  config = function(_, opts)
    local lint = require("lint")

    local bin = "/Users/johannessigvardsen/Files/Projects/Fun/rust-test/rjsonlinter/target/release/rjsonlinter"

    lint.linters.rjsonlinter = {
      name = "rjsonlinter",
      cmd = bin, -- just the binary path; system() will run it
      stdin = false,
      args = {}, -- args will be handled inside parser
      stream = "stderr", -- not used, but keep for clarity
      ignore_exitcode = true,
      parser = function(_, bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cwd = vim.fn.getcwd()

        print("DEBUG: binary path:", bin)
        print("DEBUG: buffer file path:", filename)
        print("DEBUG: cwd:", cwd)

        -- Run the linter using system() so cwd and args are fully controlled
        local cmd = bin .. " " .. filename
        local output = vim.fn.system(cmd, cwd)

        print("DEBUG: Linter raw output:\n" .. output)

        local diagnostics = {}
        for line in vim.gsplit(output, "\n", { trimempty = true }) do
          local lnum, col, msg = line:match("(%d+):(%d+):%s*(.*)")
          if lnum and col and msg then
            table.insert(diagnostics, {
              lnum = tonumber(lnum) - 1,
              col = tonumber(col) - 1,
              message = msg,
              severity = vim.diagnostic.severity.ERROR,
              source = "rjsonlinter",
            })
            break -- only the first error
          end
        end

        return diagnostics
      end,
    }

    lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft, {
      json = { "rjsonlinter" },
    })

    -- Optional: auto-lint JSON files on save
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = "*.json",
      callback = function()
        require("lint").try_lint()
      end,
    })

    -- Auto-lint JSON files when opening
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      pattern = "*.json",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}

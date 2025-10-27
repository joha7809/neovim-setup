-- lua/plugins/sourcekit.lua
local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    -- use opts function so we merge into LazyVim's default opts (on_attach, capabilities, etc.)
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Add/override a server entry for sourcekit (name 'sourcekit' is conventional)
      opts.servers.sourcekit = {
        mason = false, -- don't let mason manage it
        cmd = { "/usr/bin/sourcekit-lsp" }, -- or just "sourcekit-lsp" if on PATH
        filetypes = { "swift" },
        root_dir = util.root_pattern("Package.swift", ".git"),
        single_file_support = true,
        -- any server-specific settings can go here
        -- settings = { ... },
      }

      -- If we need to create an lspconfig.configs entry for 'sourcekit', do it in setup
      opts.setup = opts.setup or {}
      opts.setup.sourcekit = function(server_name, server_opts)
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")

        -- Create config object only if it's missing
        if not configs[sourcekit] and not configs["sourcekit"] then
          configs["sourcekit"] = {
            default_config = {
              cmd = server_opts.cmd,
              filetypes = server_opts.filetypes,
              root_dir = server_opts.root_dir or util.path.dirname(vim.fn.getcwd()),
              settings = server_opts.settings or {},
              single_file_support = server_opts.single_file_support,
            },
          }
        end

        -- Use normal lspconfig setup so LazyVim's on_attach / capabilities are used
        lspconfig["sourcekit"].setup(server_opts)
        return true -- signal: we handled the setup
      end
    end,
  },
}

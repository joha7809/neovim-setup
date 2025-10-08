return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local group = vim.api.nvim_create_augroup("swift_lsp_force", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "swift",
        group = group,
        callback = function(args)
          local bufnr = args.buf
          local lspconfig = require("lspconfig")
          local util = require("lspconfig.util")

          local root = vim.fs.dirname(
            vim.fs.find(
              { "Package.swift", ".git" },
              { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }
            )[1]
          ) or vim.fn.getcwd()

          -- Prevent multiple clients
          for _, client in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
            if client.name == "sourcekit-lsp" then
              return
            end
          end

          -- Start the client manually
          local client_id = vim.lsp.start({
            name = "sourcekit-lsp",
            cmd = { "/usr/bin/sourcekit-lsp" },
            root_dir = root,
          })

          if client_id then
            vim.lsp.buf_attach_client(bufnr, client_id)

            -- Minimal keymaps
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

            vim.notify("[Swift LSP] attached at " .. root, vim.log.levels.INFO)
          else
            vim.notify("[Swift LSP] failed to attach", vim.log.levels.ERROR)
          end
        end,
      })
    end,
  },
}

return {
  "ionide/ionide-vim",
  config = function()
    vim.g["fsharp#lsp_codelens"] = 0
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      pattern = { "*.fs", "*.fsx", "*.fsi" },
      callback = function()
        vim.lsp.codelens.refresh()
      end,
      -- buffer = 0, -- current buffer
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fsharp",
      callback = function()
        vim.opt_local.commentstring = "// %s"
      end,
    })
  end,
}

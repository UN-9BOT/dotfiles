local M = {}
M.init = function(capabilities)
  ---@type vim.lsp.ClientConfig
  local jqls_config = {
    name = "jqls",
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jq-lsp") },
    root_dir = vim.fn.getcwd(),
    capabilities = capabilities,
  }
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "jq",
    callback = function(args)
      vim.lsp.start(jqls_config)
    end,
  })
end

return M

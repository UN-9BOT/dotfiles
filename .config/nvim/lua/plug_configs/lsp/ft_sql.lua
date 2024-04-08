require("lspconfig").sqls.setup({
  cmd = { "sqls", "-config", "/home/vim9/.config/nvim/sqls.yml" },
  on_attach = function(client, bufnr)
    require("sqls").on_attach(client, bufnr)
  end,
})

local lsp_utils = require("plug_configs.lsp.utils")
local lspCapabilities = lsp_utils.lspCapabilities

require("lspconfig").lua_ls.setup({
  capabilities = lspCapabilities,
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

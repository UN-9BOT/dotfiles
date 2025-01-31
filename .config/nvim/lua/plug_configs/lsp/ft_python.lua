local M = {}
local lsputil = require("lspconfig/util")

-- NOTE: main
M.init = function(capabilities)
  require("lspconfig").pyright.setup({
    capabilities = capabilities,
    filetypes = { "python" },
    root_dir = lsputil.root_pattern(".git", "requirements.txt", "pyproject.toml", "Makefile", "README.md"),
    -- settings = {
    --   -- https://microsoft.github.io/pyright/#/configuration?id=main-configuration-options
    --   python = {
    --     analysis = {
    --       autoSearchPaths = true,
    --       diagnosticMode = "openFilesOnly",
    --       useLibraryCodeForTypes = true,
    --       -- typeCheckingMode = "strict",
    --     },
    --   },
    -- },
  })
end
return M

-- require("lspconfig").pyre.setup({ })

-- NOTE: for codeactions
-- require("lspconfig").ruff_lsp.setup({
--   filetypes = { "python" },
--   settings = {
--     organizeImports = false,
--   },
--   -- disable ruff as hover provider to avoid conflicts with pyright
--   on_attach = function(client)
--     client.server_capabilities.hoverProvider = false
--   end,
-- })

-- NOTE: https://github.com/DetachHead/basedpyright

--[[
require("lspconfig").basedpyright.setup({
  capabilities = lspCapabilities,
  filetypes = { "python" },
  root_dir = lsputil.root_pattern(".git", "requirements.txt", "pyproject.toml", "Makefile", "README.md"),
  settings = {
    -- https://microsoft.github.io/pyright/#/configuration?id=main-configuration-options
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "workspace",
      useLibraryCodeForTypes = true,
      -- typeCheckingMode = "standard",
      typeCheckingMode = "basic",
    },
    diagnosticSeverityOverrides = {
      reportUnusedCallResult = "information",
      reportUnusedExpression = "information",
      reportUnknownMemberType = "none",
      reportUnknownLambdaType = "none",
      reportUnknownParameterType = "none",
      reportMissingParameterType = "none",
      reportUnknownVariableType = "none",
      reportUnknownArgumentType = "none",
      reportAny = "none",
      reportImplicitStringConcatenation = "none",
    },
  },
})
--]]

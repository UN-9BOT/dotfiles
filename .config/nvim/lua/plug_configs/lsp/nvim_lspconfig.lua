local M = { "neovim/nvim-lspconfig" }

local utils = require("utils")
local mapping = require("plug_configs.lsp.utils").mapping

local r = utils.r

M.dependencies = {
  { "stevanmilic/nvim-lspimport" },
  { "aznhe21/actions-preview.nvim" },
  { "folke/neodev.nvim", config = r("neodev") }, -- lua api for neovim
  { "Fildo7525/pretty_hover", event = "LspAttach", opts = {}, config = r("pretty_hover") },
  { require("plug_configs.lsp.glance") },
}

M.keys = {
  { "gj", mapping.diagnostic.def, desc = "Show Diagnostics" },
  { "gd", mapping.definition.glance, desc = "Goto Definition" },
  { "gD", mapping.definition.v_def, desc = "Goto Definition in new Tab" },
  { "gr", mapping.references.glance, desc = "Goto References" },
  { "ga", mapping.code_action.custom, desc = "Code Action", mode = { "n", "v" } },
  { "gk", mapping.documentation.pretty, desc = "Show Diagnostics" },
  { "<leader>rn", mapping.rename.def, desc = "Code Action" },
}

M.init = function()
  -- this snippet enables auto-completion
  local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
  lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
  -- M.capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- M.lsputil = require("lspconfig/util")

  require("plug_configs.lsp.ft_python")
  require("plug_configs.lsp.ft_sql")
  require("plug_configs.lsp.ft_lua")
end

return M

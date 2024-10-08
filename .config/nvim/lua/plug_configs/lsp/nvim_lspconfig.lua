local M = { "neovim/nvim-lspconfig" }

M.dependencies = {}

local utils = require("utils")
local mapping = require("plug_configs.lsp.utils").mapping

local r = utils.r

M.dependencies = {
  { "stevanmilic/nvim-lspimport" },
  { "aznhe21/actions-preview.nvim" },
  { "folke/trouble.nvim" },
  { "folke/neodev.nvim", config = r("neodev") }, -- lua api for neovim
  { "Fildo7525/pretty_hover", event = "LspAttach", opts = {}, config = r("pretty_hover") },
  { "rmagatti/goto-preview", config = true },
}

M.keys = {
  { "gj", mapping.diagnostic.def, desc = "Show Diagnostics" },
  { "gdd", mapping.definition.telescope, desc = "Goto Definition" },
  { "gdv", mapping.definition.v_def, desc = "Goto Definition in vsplit" },
  { "gdh", mapping.definition.h_def, desc = "Goto Definition in hsplit" },
  { "gdt", mapping.definition.t_def, desc = "Goto Definition in new Tab" },
  { "gdT", mapping.definition.t_def, desc = "Goto Definition in new Tab" },
  { "gr", mapping.references.telescope, desc = "Goto References" },
  { "ga", mapping.code_action.custom, desc = "Code Action", mode = { "n", "v" } },
  { "gk", mapping.documentation.pretty, desc = "Show Diagnostics" },
  { "gR", mapping.rename.def, desc = "Rename" },
  { "gi", mapping.incoming_calls.telescope, desc = "Incoming Calls" },
  { "gt", mapping.type_definition.goto_preview, desc = "Goto Type Definition" },
}

M.init = function()
  -- this snippet enables auto-completion
  local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
  lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- local lsputil = require("lspconfig/util")

  require("plug_configs.lsp.ft_python")
  require("plug_configs.lsp.ft_sql")
  require("plug_configs.lsp.ft_lua")

  require("lspconfig").gitlab_ci_ls.setup({
    capabilities = capabilities,
  })
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.gitlab-ci*.{yml,yaml}",
    callback = function()
      vim.bo.filetype = "yaml.gitlab"
    end,
  })
end

return M

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
  {
    "ray-x/lsp_signature.nvim",
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts) --luacheck: ignore
      require("lsp_signature").setup({
        hint_enable = false,
        -- cursorhold_update = false,
        zindex = 45,
        max_width = 100,
      })
    end,
  },
  { "saecki/live-rename.nvim" },
}

M.keys = {
  { "gj", mapping.diagnostic.def, desc = "Show Diagnostics" },
  { "gk", mapping.documentation.pretty, desc = "Show Doc" },
  { "gdd", mapping.definition.telescope, desc = "Goto Definition" },
  { "gdv", mapping.definition.v_def, desc = "Goto Definition in vsplit" },
  { "gdh", mapping.definition.h_def, desc = "Goto Definition in hsplit" },
  { "gdt", mapping.definition.t_def, desc = "Goto Definition in new Tab" },
  { "gdmm", mapping.definition.m_m_def, desc = "Motion Goto Definition" },
  { "gdmp", mapping.definition.p_m_def, desc = "Motion Goto Definition Preview" },
  { "gdmv", mapping.definition.v_m_def, desc = "Motion Goto Definition in vsplit" },
  { "gdmh", mapping.definition.h_m_def, desc = "Motion Goto Definition in hsplit" },
  { "gdmt", mapping.definition.t_m_def, desc = "Motion Goto Definition in new Tab" },
  { "gr", mapping.references.telescope, desc = "Goto References" },
  { "ga", mapping.code_action.custom, desc = "Code Action", mode = { "n", "v" } },
  { "gR", mapping.rename.live, desc = "Rename" },
  { "gi", mapping.incoming_calls.telescope, desc = "Incoming Calls" },
  { "gt", mapping.type_definition.goto_preview, desc = "Preview Type Definition" },
  { "gT", mapping.type_definition.goto_preview_close, desc = "Close Preview Type Definition" },
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

  require("lspconfig").zls.setup({})

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

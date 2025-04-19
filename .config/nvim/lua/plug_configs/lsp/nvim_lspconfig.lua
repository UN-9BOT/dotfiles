local M = { "neovim/nvim-lspconfig" }

local g_utils = require("utils")
local mapping = require("plug_configs.lsp.utils").mapping

M.dependencies = {
  -- { "stevanmilic/nvim-lspimport" },
  { "UN-9BOT/nvim-lspimport", branch = "nvim11" },

  { "aznhe21/actions-preview.nvim" },
  { "folke/trouble.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  },
  { "Fildo7525/pretty_hover", event = "LspAttach", opts = {}, config = g_utils.r("pretty_hover") },
  { "rmagatti/goto-preview", config = true },
  {
    "ray-x/lsp_signature.nvim",
    config = function(_, opts)
      require("lsp_signature").setup({ hint_enable = false, zindex = 45, max_width = 100 })
    end,
  },
}

M.keys = {
  { "gj", mapping.diagnostic.def, desc = "Show Diagnostics" },
  { "gk", mapping.documentation.pretty, desc = "Show Doc" },
  { "gdd", mapping.definition.telescope.normal, desc = "Goto Definition" },
  { "gdv", mapping.definition.telescope.vsplit, desc = "Goto Definition in vsplit" },
  { "gdh", mapping.definition.telescope.hsplit, desc = "Goto Definition in hsplit" },
  { "gdt", mapping.definition.telescope.tab, desc = "Goto Definition in new Tab" },
  { "gdmp", mapping.definition.motion_goto_preview.normal, desc = "Motion Goto Definition Preview" },
  { "gdmm", mapping.definition.motion_telescope.normal, desc = "Motion Goto Definition" },
  { "gdmv", mapping.definition.motion_telescope.vsplit, desc = "Motion Goto Definition in vsplit" },
  { "gdmh", mapping.definition.motion_telescope.hsplit, desc = "Motion Goto Definition in hsplit" },
  { "gdmt", mapping.definition.motion_telescope.tab, desc = "Motion Goto Definition in new Tab" },
  { "gr", mapping.references.telescope, desc = "Goto References" },
  { "ga", mapping.code_action.preview, desc = "Code Action", mode = { "n", "v" } },
  { "gR", mapping.rename.live, desc = "Rename" },
  { "gi", mapping.incoming_calls.telescope, desc = "Incoming Calls" },
  { "gt", mapping.type_definition.goto_preview, desc = "Preview Type Definition" },
  { "gT", mapping.type_definition.goto_preview_close, desc = "Close Preview Type Definition" },
}

M.init = function()
  -- this snippet enables auto-completion
  vim.lsp.protocol.make_client_capabilities().textDocument.completion.completionItem.snippetSupport = true

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  require("plug_configs.lsp.ft_python").init(capabilities)
  require("plug_configs.lsp.ft_sql")
  require("plug_configs.lsp.ft_lua")
  require("plug_configs.lsp.ft_json").init(capabilities)
  require("plug_configs.lsp.ft_gitlabci").init(capabilities)
  require("lspconfig").bashls.setup({})
  require("lspconfig").zls.setup({})
  require("lspconfig").taplo.setup({})
end

return M

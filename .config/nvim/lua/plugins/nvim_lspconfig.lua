local M = {
  "neovim/nvim-lspconfig",
  dependencies = { "stevanmilic/nvim-lspimport" },
  keys = {
    -- { "gd", vim.lsp.buf.definition,  desc = "Goto Definition" },
    { "gd",         "<cmd>Telescope lsp_definitions<CR>",           desc = "Goto Definition" },
    { "gD",         ":vsplit<CR>:lua vim.lsp.buf.definition()<CR>", desc = "Goto Definition" },
    { "gr",         "<cmd>Telescope lsp_references<CR>",            desc = "Goto References" },
    { "ga",         vim.lsp.buf.code_action,                        desc = "Code Action" },
    { "gj",         vim.diagnostic.open_float,                      desc = "Show Diagnostics" },
    { "<leader>rn", vim.lsp.buf.rename,                             desc = "Code Action" },
    -- { "<leader>i",  require("lspimport").import,                    desc = "Import" },
    { "<leader>i",  "<cmd>lua require('lspimport').import()<CR>",   desc = "Import" },
    { "gy",         ":TroubleToggle<CR><c-k>",                      { silent = true } }
  },
  init = function()
    -- this snippet enables auto-completion
    local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
    lspCapabilities.textDocument.completion.completionItem.snippetSupport = true

    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- setup pyright with completion capabilities
    require("lspconfig").pyright.setup({
      capabilities = lspCapabilities,
      filetypes = { "python" },
    })
    require("lspconfig").lua_ls.setup({
      capabilities = lspCapabilities,
      filetypes = { "lua" },
    })

    -- setup taplo with completion capabilities
    -- require("lspconfig").taplo.setup({
    --     capabilities = lspCapabilities,
    -- })

    -- ruff uses an LSP proxy, therefore it needs to be enabled as if it"stevanmilic/barbecue.nvim
    -- were a LSP. In practice, ruff only provides linter-like diagnostics
    -- and some code actions, and is not a full LSP yet.
    -- require("lspconfig").ruff_lsp.setup({
    --     -- organize imports disabled, since we are already using `isort` for that
    --     -- alternative, this can be enabled to make `organize imports`
    --     -- available as code action
    --     settings = {
    --         organizeImports = false,
    --     },
    --     -- disable ruff as hover provider to avoid conflicts with pyright
    --     on_attach = function(client) client.server_capabilities.hoverProvider = false end,
    -- })
  end,
}


return M

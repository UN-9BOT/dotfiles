local M = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim", opts = true },
    { "williamboman/mason-lspconfig.nvim", opts = true },
    { "jay-babu/mason-nvim-dap.nvim" },
  },
  opts = {
  },
}
M.config = function()
  require("mason-tool-installer").setup({

    ensure_installed = {
      -- python
      "pyright", -- LSP for python
      "ruff", -- linter for python (includes flake8, pep8, etc.)
      "black", -- formatter
      "isort", -- organize imports
      "docformatter", -- docstring formatter
      -- toml
      "taplo", -- LSP for toml (for pyproject.toml files)
      -- docker
      "docker-compose-language-service",
      "dockerfile-language-server",
      "hadolint",
      -- yaml
      "yamllint",
      "actionlint",
      -- lua
      "lua-language-server",
      "stylua",
      -- "luacheck",
      "selene",
      -- makefile
      "checkmake",
      --json
      "fixjson",
      "jqls",
      -- sql
      "sql-formatter",
      "sqlfluff",
      "sqls",
      -- xml
      "xmlformatter",
    },

    auto_update = false,

    run_on_start = false,


    integrations = {
      ["mason-lspconfig"] = true,
      ["mason-null-ls"] = true,
      ["mason-nvim-dap"] = true,
    },
  })
end

return M

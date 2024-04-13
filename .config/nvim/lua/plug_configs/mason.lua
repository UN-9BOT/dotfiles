local M = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    { "williamboman/mason.nvim",           opts = true },
    { "williamboman/mason-lspconfig.nvim", opts = true },
  },
  opts = {
    ensure_installed = {
      -- python
      "pyright",  -- LSP for python
      "ruff-lsp", -- linter for python (includes flake8, pep8, etc.)
      "ruff",     -- linter for python (includes flake8, pep8, etc.)
      "debugpy",  -- debugger
      "black",    -- formatter
      "isort",    -- organize imports
      -- toml
      "taplo",    -- LSP for toml (for pyproject.toml files)
      -- C
      "clangd",
      "cpptools",
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
      "luacheck",
      -- makefile
      "checkmake",
      -- c
      "clang-format",
      --json
      "fixjson",
      -- sql
      "sql-formatter",
      "sqlfluff",
      "sqls",
      -- xml
      "xmlformatter",
    },
  },
}

return M

local M = {
  "stevearc/conform.nvim",
  lazy = true,
}

M.opts = {}

M.config = function()
  local conform = require("conform")
  conform.setup({
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      python = { "black" },
      -- python = { "black", "docformatter" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      -- sql = { "sql_formatter" },
      sql = { "sqlfluff" },
      xml = { "xmllint" },
      json = { "fixjson" },
      c = { "clang-format" },
      yaml = { "yamlfmt" },
      sh = { "shfmt" },
    },
  })
  conform.formatters.shfmt = { prepend_args = { "-i", "4", "-bn", "-ci", "-sr" } }
  conform.formatters.docformatter = { prepend_args = { "--black" } }
  conform.formatters.stylua = { prepend_args = { "--config-path", "/home/vim9/.config/nvim/stylua.toml" } }
  -- conform.formatters.sql_formatter = { prepend_args = { "-l", "postgresql" } }
  conform.formatters.sqlfluff = { append_args = { "--config", "/home/vim9/.config/nvim/.sqlfluff" } }
  conform.formatters.yamlfmt = { prepend_args = { "-conf", "/home/vim9/.config/nvim/yamlfmt.yml" } }

  -- local black_args = { "--fast", "-l", "120" }
  local black_args = { "-l", "120" }
  if vim.fn.filereadable("pyproject.toml") == 1 then
    black_args = { "--config", "pyproject.toml" }
  end
  -- local black_command = require("utils").get_pythonPath() .. " -m black"
  -- -- TODO: local and global
  -- if not vim.fn.executable(black_command) then
  --   black_command = "black"
  -- end
  black_command = "black"
  _G.nn = black_command
  conform.formatters.black = { prepend_args = black_args, command = black_command }

  conform.formatters.clang_format = { prepend_args = { "-style", "/home/vim9/.config/nvim/.clang-format" } }
end

M.keys = {
  {
    "<leader>ff",
    function()
      local args = {}
      if vim.bo.filetype == "python" then
        args = { timeout_ms = 5000 }
      end
      local okay_conform = require("conform").format(args)

      if not okay_conform then
        for _, client in pairs(vim.lsp.get_clients()) do
          if client.supports_method("textDocument/formatting") then
            vim.lsp.buf.format({ async = true })
            vim.notify("LSP:format")
          end
        end
      else
        vim.notify("󰏣:Conform:format")
      end
    end,
    mode = { "n", "v" },
    desc = "Conform: default format",
  },
  {
    "<leader>fF",
    function()
      local okay_conform = require("conform").format({ timeout_ms = 5000, formatters = { "docformatter" } })
      if not okay_conform then
        vim.notify("󰏣:Conform: docformatter Error", 4)
      else
        vim.notify("󰏣:Conform: docformatter Success")
      end
    end,
    mode = { "n", "v" },
    desc = "Conform: docformatter",
  },
}
return M

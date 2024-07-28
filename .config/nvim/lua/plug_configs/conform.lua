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
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      sql = { "sql_formatter" },
      xml = { "xmllint" },
      json = { "fixjson" },
      c = { "clang-format" },
      yaml = { "yamlfmt" },
    },
  })
  conform.formatters.shfmt = { prepend_args = { "-i", "2", "-bn", "-ci", "-sr" } }
  conform.formatters.stylua = { prepend_args = { "--config-path", "/home/vim9/.config/nvim/stylua.toml" } }
  conform.formatters.sql_formatter = { prepend_args = { "-l", "postgresql" } }
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
    "<leader>F",
    function()
      local args = {}
      if vim.bo.filetype == "python" then
        args = {timeout_ms = 5000}
      end 
      local okay_conform = require("conform").format(args)

      if not okay_conform then
        for _, client in pairs(vim.lsp.get_clients()) do
          if client.supports_method("textDocument/formatting") then
            vim.lsp.buf.format({ async = true })
            require("plug_configs.notify").nf("LSP:format")
          end
        end
      else
        require("plug_configs.notify").nf("󰏣:Conform:format")
      end
    end,
    mode = { "n", "v" },
    desc = "Format Injected Langs",
  },
}
return M

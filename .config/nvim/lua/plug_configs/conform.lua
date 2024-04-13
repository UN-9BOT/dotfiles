local M = {
  "stevearc/conform.nvim",
}

M.opts = {}

M.config = function()
  local conform = require("conform")
  conform.setup({

    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      sql = { "sql_formatter" },
      xml = { "xmllint" },
      json = { "fixjson" },
      c = { "clang-format" },
    },
  })
  conform.formatters.shfmt = { prepend_args = { "-i", "2", "-bn", "-ci", "-sr" } }
  conform.formatters.stylua = { prepend_args = { "--config-path", "/home/vim9/.config/nvim/stylua.toml" } }
  conform.formatters.sql_formatter = { prepend_args = { "-l", "postgresql" } }
  conform.formatters.black = { prepend_args = { "--fast" } }
  conform.formatters.clang_format = { prepend_args = { "-style", "/home/vim9/.config/nvim/.clang-format" } }
end

M.keys = {
  {
    "<leader>F",
    function()
      local _ = function()
        local buf_clients = vim.lsp.get_active_clients()

        -- Check LSP clients that support formatting
        for _, client in pairs(buf_clients) do
          if client.supports_method('textDocument/formatting') then
            vim.lsp.buf.format { async = true }
            return
          end
        end

        -- fallback
        require("conform").format({})
      end
      _()
      require("plug_configs.notify").nf("󰏣:Conform done")
    end,
    mode = { "n", "v" },
    desc = "Format Injected Langs",
  },
}
return M

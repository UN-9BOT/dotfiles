return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.register({
      name = "add type: ignore",
      method = { require("null-ls").methods.CODE_ACTION },
      filetypes = { "python", "lua" },
      generator = {
        fn = function()
          return {
            {
              title = "# type: ignore",
              action = function()
                local line = vim.api.nvim_get_current_line()
                if vim.bo.filetype == "python" then
                  vim.api.nvim_set_current_line(line .. "  # type: ignore")
                elseif vim.bo.filetype == "lua" then
                  vim.api.nvim_set_current_line(line .. "  --luacheck: ignore")
                end
              end,
            },
          }
        end,
      },
    })
    null_ls.register({
      name = "add pyright: ignore",
      method = { require("null-ls").methods.CODE_ACTION },
      filetypes = { "python", "lua" },
      generator = {
        fn = function()
          return {
            {
              title = "# pyright: ignore",
              action = function()
                local line = vim.api.nvim_get_current_line()
                vim.api.nvim_set_current_line(line .. "  # pyright: ignore")
              end,
            },
          }
        end,
      },
    })
    null_ls.register({
      name = "add noqa",
      method = { require("null-ls").methods.CODE_ACTION },
      filetypes = { "python" },
      generator = {
        fn = function()
          return {
            {
              title = "# noqa",
              action = function()
                local line = vim.api.nvim_get_current_line()
                vim.api.nvim_set_current_line(line .. "  # noqa")
              end,
            },
          }
        end,
      },
    })
    null_ls.setup({
      sources = {
        -- null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.formatting.fish_indent,
        -- null_ls.builtins.formatting.stylua,  -- in lua_ls
        null_ls.builtins.formatting.shfmt,
      },
    })
  end,
}

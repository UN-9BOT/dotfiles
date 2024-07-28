return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.register({
      name = "add type ignore",
      method = { require("null-ls").methods.CODE_ACTION },
      filetypes = { "python", "lua" },
      generator = {
        fn = function()
          return {
            {
              title = "# type: ignore",
              action = function()
                if vim.bo.filetype == "python" then
                  vim.cmd("normal! A  # type: ignore")
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
                elseif vim.bo.filetype == "lua" then
                  vim.cmd("normal! A --luacheck: ignore")
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
                end
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
                vim.cmd("normal! A  # noqa")
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
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

return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local linters = lint.linters

    lint.linters_by_ft = {
      python = { "ruff", "mypy" },
      c = { "cppcheck", "clangtidy" },
      sh = { "zsh", "shellcheck" },
      dockerfile = { "hadolint" },
      Dockerfile = { "hadolint" },
      docker = { "hadolint" },
      -- yaml = { "actionlint", "yamllint" },
      yaml = { "yamllint" },
      -- make = { "checkmake" },  -- TODO: доделать парсер
    }

    --------
    --------
    -- makefile
    -- linters.checkmake = {
    --   cmd = "checkmake",
    --   args = {'--format="{{.LineNumber}}:{{.Rule}}:{{.Violation}}{{\"\r\n\"}}"', ' %s'},
    --   parser = function(output)
    --     local diags = {}
    --     for _, line in ipairs(vim.split(output, "\n")) do
    --       local lnum, sev, msg = line:find('\v^(%d+):(.+):(.+)$')
    --       diags[#diags + 1] = {
    --         lnum = tonumber(lnum),
    --         severity = sev,
    --         message = msg,
    --         source = "checkmake",
    --       }
    --     end
    --
    --     return diags
    --   end,
    -- }
    --------
    --------

    table.insert(lint.linters.mypy.args, "--ignore-missing-imports")

    -- ruff
    local new_ruff_args = { "--config=~/.config/nvim/ruff.toml" }
    for i = 1, #new_ruff_args do
      lint.linters.ruff.args[#lint.linters.ruff.args + 1] = new_ruff_args[i]
    end

    --------
    --------
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end
}

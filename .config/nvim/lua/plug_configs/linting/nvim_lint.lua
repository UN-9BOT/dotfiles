local M = {
  "mfussenegger/nvim-lint",
}
local lint_utils = require("plug_configs.linting.utils")

M.config = function()
  local lint = require("lint")
  local linters = lint.linters
  -- vim.notify = require("plug_configs.notify").nf

  lint.linters_by_ft = {
    python = { "ruff" },
    c = { "cppcheck", "clangtidy" },
    sh = { "zsh", "shellcheck" },
    dockerfile = { "hadolint" },
    Dockerfile = { "hadolint" },
    docker = { "hadolint" },
    lua = { "luacheck" },
    yaml = { "yamllint" },
    -- yaml = { "actionlint", "yamllint" },
    sql = { "sqlfluff" },
    make = { "checkmake" },
  }

  --------
  --------

  -- cppcheck
  linters.cppcheck.args = {
    "--enable=warning,style,performance,information",
    function()
      if vim.bo.filetype == "cpp" then
        return "--language=c++"
      else
        return "--language=c"
      end
    end,
    "--inline-suppr",
    "--quiet",
    "--template={file}:{line}:{column}: [{id}] {severity}: {message}",
    "--suppress=missingIncludeSystem",
  }
  -- luacheck
  local new_luacheck_args = { "--globals", "vim" }
  for i = 1, #new_luacheck_args do
    lint.linters.luacheck.args[#lint.linters.luacheck.args + 1] = new_luacheck_args[i]
  end

  -- mypy
  table.insert(linters.mypy.args, "--ignore-missing-imports")
  table.insert(linters.mypy.args, "--check-untyped-defs")
  -- if pyproject.toml exist
  if vim.fn.filereadable("pyproject.toml") == 1 then
    table.insert(linters.mypy.args, "--config=pyproject.toml")
  end

  -- ruff
  local new_ruff_args = { "--config=~/.config/nvim/ruff.toml" }
  for i = 1, #new_ruff_args do
    lint.linters.ruff.args[#lint.linters.ruff.args + 1] = new_ruff_args[i]
  end

  -- yamllint
  local new_yamllint_args = { "-d", "{extends: relaxed, rules: {line-length: {max: 130}}}" }
  for i = 1, #new_yamllint_args do
    lint.linters.yamllint.args[#lint.linters.yamllint.args + 1] = new_yamllint_args[i]
  end
  -- sqlfluff
  linters.sqlfluff.args = {
    "lint",
    "--format=json",
    -- note: users will have to replace the --dialect argument accordingly
    "--dialect=postgres",
  }

  --------
  --------
  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })


  vim.diagnostic.config({
    -- virtual_lines = { only_current_line = true }, -- for lsp_lines.nvim
    virtual_text = false,
    float = {
      border = "rounded",
      header = false, -- remove the line that says 'Diagnostic:'
      source = false, -- hide it since my float_format will add it
      format = lint_utils.float_format, -- can customize more colors by using prefix/suffix instead
      suffix = "", -- default is error code. Moved to message via float_format
    },
    update_in_insert = false, -- wait until insert leave to check diagnostics
  })


  -- NOTE: toggle mypy
  _G.is_mypy_enabled = false
  vim.keymap.set("n", "gl", lint_utils.toggle_mypy(lint), { desc = "Toggle mypy" })
end

return M

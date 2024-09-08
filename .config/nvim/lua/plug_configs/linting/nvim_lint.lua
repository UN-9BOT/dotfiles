local M = {
  "mfussenegger/nvim-lint",
}
local lint_utils = require("plug_configs.linting.utils")

M.config = function()
  local lint = require("lint")
  local linters = lint.linters

  lint.linters_by_ft = {
    python = { "ruff" },
    c = { "cppcheck", "clangtidy" },
    sh = { "zsh", "shellcheck" },
    dockerfile = { "hadolint" },
    -- lua = { "luacheck" },
    lua = { "selene" },
    -- yaml = { "yamllint" },
    -- yaml = { "actionlint", "yamllint" },
    sql = { "sqlfluff" },
    make = { "checkmake" },
  }

  --------
  --------

  local cppcheck_args = { "--suppress=missingIncludeSystem" }
  vim.list_extend(linters.cppcheck.args, cppcheck_args)

  local luacheck_args = { "--globals", "vim" }
  vim.list_extend(linters.luacheck.args, luacheck_args)

  local mypy_args = { "--ignore-missing-imports", "--check-untyped-defs", "--config-file=pyproject.toml" }
  vim.list_extend(linters.mypy.args, mypy_args)

  local ruff_args = { "--config=~/.config/nvim/ruff.toml" }
  vim.list_extend(linters.ruff.args, ruff_args)

  -- local new_yamllint_args = { "-d", "{extends: relaxed, rules: {line-length: {max: 130}}}" }
  -- vim.list_extend(linters.yamllint.args, new_yamllint_args)

  linters.sqlfluff.args = { "lint", "--format=json", "--config=/home/vim9/.config/nvim/.sqlfluff" }

  --------
  --------
  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
  vim.api.nvim_create_autocmd({ "TextChanged" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
      -- require("plug_configs.notify").nf("Lint(au):try_lint")
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

  -- restart lsp
  vim.keymap.set("n", "gL", function()
    vim.cmd("LspRestart")
  end, { desc = "Restart lint" })

  vim.api.nvim_set_keymap(
    "n",
    "<leader>g[",
    "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>g]",
    "<cmd>lua vim.diagnostic.goto_next()<CR>",
    { noremap = true, silent = true }
  )
  -- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
  vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
  -- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
  -- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
end

return M

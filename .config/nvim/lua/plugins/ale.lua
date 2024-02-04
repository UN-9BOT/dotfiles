-- WARNING: DISABLE -> switch to nvim-lint
local M = {
  "dense-analysis/ale",
}
M.config = function()
  vim.g.ale_virtualtext_cursor = "disable"
  vim.g.ale_completion_enabled = 0
  vim.g.ale_use_neovim_diagnostics_api = 1

  vim.g.ale_echo_msg_format = '%s > [%severity%]-[%linter%]'
  vim.g.ale_loclist_msg_format = " %s"
  -- vim.g.ale_loclist_msg_format = ' %s > [%severity%]-[%linter%] >> %...code...%'

  vim.g.ale_python_mypy_options = "--ignore-missing-imports"

  vim.g.ale_python_bandit_options = "--skip B101"



  vim.g.ale_sign_info            = 'I'
  vim.g.ale_sign_warning         = 'W'
  vim.g.ale_sign_error           = 'E'
  vim.g.ale_echo_msg_warning_str = 'W'
  vim.g.ale_echo_msg_error_str   = 'E'
  vim.g.ale_echo_msg_info_str    = 'I'

  vim.g.ale_python_ruff_options  = ' --config ~/.config/nvim/ruff.toml'

  vim.g.ale_sh_shfmt_options     = '-i 4 -ci'

  vim.g.ale_linters              = {
    -- python = { "ruff", "mypy", "refurb" },
    python = { "ruff", "mypy" },
    -- python = {},
    c = { "clangd", "cppcheck", "clang-tidy", "splint" },
    cpp = { "clang", "clang-check", "clang-tidy", "splint" },
    html = { "vscode-html-languageserver", "tidy" },
    htmldjango = { "vscode-html-languageserver", "tidy" },
    sh = { "bashate", "shellcheck", "zsh" },
    dockerfile = { "dockle", "hadolint", "dockerfile_lint" }
    -- sh = {},
  }
end

return M

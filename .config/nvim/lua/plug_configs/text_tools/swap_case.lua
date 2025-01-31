local M = { "johmsalas/text-case.nvim", lazy = true }

M.config = function()
  require("textcase").setup({ default_keymappings_enabled = false })
end

M.keys = {
  "gs", -- Default invocation prefix
  { "gsl", "<cmd>TextCaseOpenTelescopeLSPChange<CR>", mode = { "n", "x" }, desc = "Swap Case (LSP)" },
  { "gsq", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", mode = { "n", "x" }, desc = "Swap Case (Quick)" },
}

M.cmd = {
  "TextCaseOpenTelescope",
  "TextCaseOpenTelescopeQuickChange",
  "TextCaseOpenTelescopeLSPChange",
  "TextCaseStartReplacingCommand",
}

return M

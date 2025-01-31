local M = {
  "supermaven-inc/supermaven-nvim",
}

M.config = function()
  require("supermaven-nvim").setup({
    keymaps = {
      accept_suggestion = "<A-g>",
      clear_suggestion = "<A-c>",
      accept_word = "<A-f>",
    },
    ignore_filetypes = {
      "TelescopePrompt",
      "TelescopeResults",
      "dap-repl",
      "help",
      "grug-far",
      "grug-far-history",
      "grug-far-help",
    },
    log_level = "info", -- set to "off" to disable logging completely
    disable_inline_completion = false, -- disables inline completion for use with cmp
    disable_keymaps = false, -- disables built in keymaps for more manual control
    condition = function()
      return false
    end,
  })

  local b = vim.keymap.set

  local clean_toggle = function()
    local api = require("supermaven-nvim.api")
    local completion_preview = require("supermaven-nvim.completion_preview")
    api.toggle()
    completion_preview.on_dispose_inlay()
  end

  b({ "n", "i" }, "<F19>", clean_toggle)

  vim.g.SUPERMAVEN_DISABLED = 1
end

return M

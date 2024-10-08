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
  })
end

return M

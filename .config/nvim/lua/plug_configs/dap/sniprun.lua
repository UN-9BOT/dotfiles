local M = {
  "michaelb/sniprun",
  branch = "master",
  build = "sh install.sh", -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
}

M.config = function()
  require("sniprun").setup({
    display = { "TerminalWithCode" },
    live_mode_toggle = "enable",
    display_options = {
      terminal_scrollback = vim.o.scrollback, -- change terminal display scrollback lines
      terminal_line_number = false, -- whether show line number in terminal window
      terminal_signcolumn = false, -- whether show signcolumn in terminal window
      terminal_position = "vertical", --# or "horizontal", to open as horizontal split instead of vertical split
      terminal_width = 65, --# change the terminal display option width (if vertical)
      terminal_height = 20, --# change the terminal display option height (if horizontal)
    },

    selected_interpreters = { "Python3_fifo" },
    repl_enable = { "Python3_fifo" },
    interpreter_options = { --# interpreter-specific options, see doc / :SnipInfo <name>
      Python3_fifo = {
        interpreter = require("utils").get_pythonPath(),
      },
    },
  })

  vim.keymap.set({ "n" }, "<F10>", ":SnipRun<cr>")
  vim.keymap.set({ "v" }, "<F10>", ":SnipRun<cr>gv")
end

return M

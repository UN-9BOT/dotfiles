local M = {
  "michaelb/sniprun",
  branch = "master",
  build = "sh install.sh", -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
}
M.config = function()
  require("sniprun").setup({
    display = { "Terminal" },
    display_options = {
      terminal_scrollback = vim.o.scrollback,   -- change terminal display scrollback lines
      terminal_line_number = false,             -- whether show line number in terminal window
      terminal_signcolumn = false,              -- whether show signcolumn in terminal window
      terminal_position = "vertical",           --# or "horizontal", to open as horizontal split instead of vertical split
      terminal_width = 45,                      --# change the terminal display option width (if vertical)
      terminal_height = 20,                     --# change the terminal display option height (if horizontal)
    },
  })
  local b = vim.keymap.set
  b({ "n", "v" }, "<F10>", ":SnipRun<cr>")
end

return M

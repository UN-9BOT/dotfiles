local M = {
  "michaelb/sniprun",
  branch = "master",
  build = "sh install.sh", -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
}
M.config = function()
  require("sniprun").setup({})
  local b = vim.keymap.set
  b({ "n", "v" }, "<F10>", ":SnipRun<cr>")
end

return M

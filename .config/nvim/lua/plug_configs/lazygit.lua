-- https://github.com/kdheepak/lazygit.nvim
local M = {
  "kdheepak/lazygit.nvim",
}
M.config = function()
  if vim.fn.has("nvim") and vim.fn.executable("nvr") then
    vim.g.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  end
  vim.cmd([[
    autocmd Filetype lazygit tnoremap <buffer><nowait> <leader> <leader>
  ]]) -- NOTE: для отключение задержки на leader(space)
end

local function DiffviewToggle()
  local lib = require("diffview.lib")
  local view = lib.get_current_view()
  if view then
    -- Current tabpage is a Diffview; close it
    vim.cmd("DiffviewClose")
  else
    -- No open Diffview exists: open a new one
    vim.cmd("DiffviewOpen")
  end
end

M.keys = {
  { "<leader>lg", "<cmd>LazyGit<CR>",                            mode = { "n" }, desc = "LazyGit" },
  { "<leader>D",  function() vim.cmd("DiffviewFileHistory") end, mode = { "v" }, desc = "Show history for selected" },
  { "<leader>D",  DiffviewToggle,                                mode = { "n" }, desc = "DiffviewToggle" },
}

return M

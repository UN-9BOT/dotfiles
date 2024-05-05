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
  if require("diffview.lib").get_current_view() then
    vim.cmd("DiffviewClose")
  else
    local mode = vim.api.nvim_get_mode().mode
    if mode == "v" or mode == "V" or mode == "" then
      vim.cmd([[noautocmd silent normal! "vy]])

      ---@diagnostic disable-next-line: param-type-mismatch
      vim.fn.setreg("v", vim.fn.getreg("v"), vim.fn.getregtype("v"))
      vim.split(vim.fn.getreg("v"), "\n")

      vim.cmd("'<,'>DiffviewFileHistory")
      return
    end
    vim.cmd("DiffviewOpen")
  end
end

M.keys = {
  { "<leader>lg", "<cmd>LazyGit<CR>", mode = { "n" }, desc = "LazyGit" },
  { "<leader>D", DiffviewToggle, mode = { "n", "v" }, desc = "DiffviewToggle" },
}

return M

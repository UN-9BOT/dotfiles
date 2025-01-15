local M = { "sindrets/diffview.nvim", lazy = false }

_G.__save_win_diff_view = nil

local function DiffviewToggle()
  if require("diffview.lib").get_current_view() then
    vim.cmd("DiffviewClose")
    if _G.__save_win_diff_view and vim.api.nvim_win_is_valid(_G.__save_win_diff_view) then
      vim.api.nvim_set_current_win(_G.__save_win_diff_view)
      _G.__save_win_diff_view = nil
    end
  else
    local mode = vim.api.nvim_get_mode().mode
    _G.__save_win_diff_view = vim.api.nvim_get_current_win()
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
  { "<leader>D", DiffviewToggle, mode = { "n", "v" }, desc = "DiffviewToggle" },
}

return M

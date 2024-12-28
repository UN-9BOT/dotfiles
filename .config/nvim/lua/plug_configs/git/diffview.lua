local M = { "sindrets/diffview.nvim", lazy = false }

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
  { "<leader>D", DiffviewToggle, mode = { "n", "v" }, desc = "DiffviewToggle" },
}


return M

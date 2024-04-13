local M = {
  "nvim-pack/nvim-spectre",
}

M.__send_to_trouble = function()
  require("spectre.actions").send_to_qf()
  vim.cmd("cclose")
  vim.cmd("Trouble quickfix")
end

M.config = function()
  require("spectre").setup({
    is_block_ui_break = true,
    -- open_cmd = "new",
    live_update = true,
    line_sep_start = "",
    line_sep = "",
    mapping = {
      ["send_to_qf"] = {
        map = "<leader>q",
        cmd = "<cmd>lua require('plug_configs.spectre').__send_to_trouble()<CR>",
        desc = "send all items to quickfix",
      },
    },
  })
end

return M

local M = {
  "rolv-apneseth/tfm.nvim",
}

M.keys = {
  {
    "<leader>e",
    function()
      local tfm = require("tfm")
      tfm.open(nil, tfm.OPEN_MODE.tabedit)
    end,
    desc = "TFM(yazi) - new tab",
  },
}

M.opts = {
  replace_netrw = true,
  file_manager = "ranger",
  ui = {
    border = "rounded",
    height = 0.90,
    width = 0.9,
    x = 0.5,
    y = 0.5,
  },
}


return M

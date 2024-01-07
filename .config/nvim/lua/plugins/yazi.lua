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

return M

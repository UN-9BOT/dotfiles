local M = {
  "FabijanZulj/blame.nvim",
}

M.config = function()
  require("blame").setup()
end

M.keys = {
  { "\\gB", mode = "n", "<cmd>BlameToggle<cr>" },
}
return M

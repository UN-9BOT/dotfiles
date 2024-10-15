local M = {
  "ariel-frischer/bmessages.nvim",
  lazy=true,
}

M.event = "CmdlineEnter"

M.config = function()
  vim.api.nvim_command("cnoreabbrev messages Bmessages") -- alias for replace default messages
  require("bmessages").setup()
end

return M

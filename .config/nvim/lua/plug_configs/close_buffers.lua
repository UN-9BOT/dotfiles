local M = {
  "kazhala/close-buffers.nvim", -- autoclose hidden buffers (optimization)
}
M.config = function()
  vim.api.nvim_create_autocmd("BufAdd", {
    callback = function()
      vim.schedule(function()
        require("close_buffers").delete({ type = "hidden", force = true })
      end)
    end,
  })
end

return M

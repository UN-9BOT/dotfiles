local M = {
  "m-demare/attempt.nvim",
}

M.config = function()
  local attempt = require("attempt")
  attempt.setup({

    ext_options = { "lua", "json", "py", "" }, -- Options to choose from
  })

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts = vim.tbl_extend("force", { silent = true }, opts)
    vim.keymap.set(mode, l, r, opts)
  end

  map("n", "<leader>an", function()
    vim.cmd.tabedit()
    attempt.new_select()
  end, { desc = "New attempt" })
  map("n", "<leader>ad", attempt.delete_buf, { desc = "Delete attempt from current buffer" })
  map("n", "<leader>ac", attempt.rename_buf, { desc = "Rename attempt from current buffer" })
  map("n", "<leader>al", require("telescope").extensions.attempt.attempt, { desc = "Search through attempts" })
end

return M

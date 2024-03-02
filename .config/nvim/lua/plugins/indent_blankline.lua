local M = {
  "lukas-reineke/indent-blankline.nvim",
}

M.config = function()
  ---@diagnostic disable-next-line: undefined-global
  vim.opt.list = true
  -- vim.cmd [[set lcs+=space:·]]  -- NOTE: точки для пробелов

  require("ibl").setup({
    indent = { highlight = { "CursorColumn", "Whitespace" }, char = "" },
    -- whitespace = { highlight = { "CursorColumn", "Whitespace" }, remove_blankline_trail = false },  -- NOTE: выделение пробелов серым
    scope = { enabled = false },  -- NOTE:  это выделение контекста чертой
  })
end

return M

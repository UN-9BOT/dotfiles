local M = {
  "monkoose/neocodeium",
  event = "VeryLazy",
}

M.config = function()
  local neocodeium = require("neocodeium")
  neocodeium.setup({
    manual = true,
  })
  vim.keymap.set("i", "<A-g>", function()
    require("neocodeium").accept()
  end)
  vim.keymap.set("i", "<A-f>", function()
    require("neocodeium").accept_word()
  end)
  vim.keymap.set("i", "<A-a>", function()
    require("neocodeium").accept_line()
  end)
  vim.keymap.set("i", "<A-e>", function()
    require("neocodeium").cycle_or_complete()
  end)
  vim.keymap.set("i", "<A-r>", function()
    require("neocodeium").cycle_or_complete(-1)
  end)
  vim.keymap.set("i", "<A-c>", function()
    print(require("cmp.config.context").in_syntax_group("Comment"))
    require("neocodeium").clear()
  end)
  vim.keymap.set("i", "<A-r>", function()
    require("neocodeium").toggle()
  end)
end

return M

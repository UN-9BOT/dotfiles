local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
}
M.config = function()
  local harpoon = require("harpoon")

  -- REQUIRED
  harpoon:setup()
  -- REQUIRED

  vim.keymap.set("n", ";M", function() harpoon:list():append() end)
  vim.keymap.set("n", ";m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

  vim.keymap.set("n", ";1", function() harpoon:list():select(1) end)
  vim.keymap.set("n", ";2", function() harpoon:list():select(2) end)
  vim.keymap.set("n", ";3", function() harpoon:list():select(3) end)
  vim.keymap.set("n", ";4", function() harpoon:list():select(4) end)

  -- Toggle previous & next buffers stored within Harpoon list
  vim.keymap.set("n", ";k", function() harpoon:list():prev() end)
  vim.keymap.set("n", ";j", function() harpoon:list():next() end)
  harpoon:extend({
    UI_CREATE = function(cx)
      vim.keymap.set("n", ";s", function()
        harpoon.ui:select_menu_item({ vsplit = true })
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", ";S", function()
        harpoon.ui:select_menu_item({ split = true })
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", ";n", function()
        harpoon.ui:select_menu_item({ tabedit = true })
      end, { buffer = cx.bufnr })
    end,
  })
end


return M

local M = {
  "monkoose/neocodeium",
  event = "VeryLazy",
}

M.config = function()
  local neocodeium = require("neocodeium")

  -- cmp.event:on("menu_opened", function()
  --   neocodeium.clear()
  -- end)

  local filetypes = { "lua", "python", "sql", "bash", "sh", "md" , "xml"}
  neocodeium.setup({
    manual = true,
    max_lines = 0,
    filter = function(bufnr)
      if vim.tbl_contains(filetypes, vim.api.nvim_get_option_value("filetype", { buf = bufnr })) then
        return true
      end
      return false
    end,
    filetypes = {
      TelescopePrompt = false,
      ["dap-repl"] = false,
    },
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "NeoCodeiumCompletionDisplayed",
    callback = function()
      require("cmp").abort()
    end,
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
    require("neocodeium").clear()
  end)
  -- vim.keymap.set("i", "<A-t>", function()
  --   require("neocodeium").toggle()
  -- end)
end

return M

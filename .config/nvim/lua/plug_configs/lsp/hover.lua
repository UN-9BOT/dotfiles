local M = {
  "roobert/hoversplit.nvim",
}

M.config = function()
  require("hoversplit").setup({
    key_bindings = {
      split = "<leader>H",
      split_remain_focused = "<Nop>",
      vsplit_remain_focused = "<Nop>",
      vsplit = "<Nop>",
    },
  })
  -- vim.api.nvim_create_autocmd({  "TabNewEntered", "VimEnter" }, {
  --   desc = "AutoOpen Hoversplit",
  --   callback = function()
  --     require("hoversplit").split()
  --   end,
  -- })
  vim.api.nvim_create_autocmd({ "ExitPre" }, {
    desc = "Close Hoversplit",
    callback = function()
      require("hoversplit").close_hover_split()
    end,
  })
end

return M

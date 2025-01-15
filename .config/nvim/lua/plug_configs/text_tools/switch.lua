local M = { -- swap true / false  (toggle)  mapping "-"
  "AndrewRadev/switch.vim",
  vscode = false,
  keys = {
    {
      "-",
      function()
        vim.cmd("Switch")
      end,
      desc = "Switch",
    },
  },

  config = function()
    vim.g.switch_mapping = ""
  end,
}

return M

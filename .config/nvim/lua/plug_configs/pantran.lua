return {
  "potamides/pantran.nvim",
  config = function()
    local opts = { noremap = true, silent = true, expr = true }
    local pantran = require("pantran")
    vim.keymap.set("n", "<leader>tr", pantran.motion_translate, opts)
    vim.keymap.set("n", "<leader>trr", function()
      return pantran.motion_translate() .. "_"
    end, opts)
    vim.keymap.set("x", "<leader>tr", pantran.motion_translate, opts)

    require("pantran").setup({
      default_engine = "yandex",
      engines = {
        yandex = {
          default_source = "en",
          default_target = "ru",
          fallback = {
            default_source = "en",
            default_target = "ru",
          },
        },
      },
    })
  end,
}

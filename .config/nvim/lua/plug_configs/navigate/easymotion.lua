local M = { "folke/flash.nvim", lazy = false }

M.keys = {
  {
    "s",
    mode = { "n", "x", "o" },
    function()
      require("flash").jump()
    end,
    desc = "Flash",
  },
  {
    "<c-s>",
    mode = { "c" },
    function()
      require("flash").toggle()
    end,
    desc = "Toggle Flash Search",
  },
  {
    "S",
    mode = { "n", "x", "o" },
    function()
      require("flash").treesitter({
        label = {
          rainbow = {
            enabled = true,
          },
        },
      })
    end,
    desc = "Flash Treesitter",
  },
  -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  {
    "R",
    mode = { "o", "x", "n" },
    function()
      require("flash").treesitter_search({
        label = {
          rainbow = {
            enabled = true,
          },
        },
      })
    end,
    desc = "Treesitter Search",
  },
}
-- M.config = function ()
-- end
M.opts = {
  modes = {
    char = {
      enabled = false,
    },
  },
}

return M

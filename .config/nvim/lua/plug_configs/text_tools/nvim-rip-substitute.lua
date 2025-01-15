local M = {
  "chrisgrieser/nvim-rip-substitute",
  cmd = "RipSubstitute",
  keys = {
    {
      "<leader>fs",
      function()
        local ripSubstitute = require("rip-substitute")
        if vim.fn.mode() == "V" then
          ripSubstitute.rememberCursorWord()
        end
        ripSubstitute.sub()
      end,
      mode = { "n", "x" },
      desc = " rip substitute",
    },
  },
}

return M

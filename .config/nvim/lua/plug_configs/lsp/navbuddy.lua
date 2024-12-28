local M = { "SmiteshP/nvim-navbuddy", lazy = true }

M.dependencies = {
  "SmiteshP/nvim-navic",
  "MunifTanjim/nui.nvim",
}

M.keys = {
  {
    ",n",
    mode = { "n" },
    function()
      require("nvim-navbuddy").open()
    end,
    desc = "LSP: Navbuddy",
  },
}

M.config = function()
  local navbuddy = require("nvim-navbuddy")
  vim.api.nvim_set_hl(0, "NavbuddyScope", { bg = "#414550" })
  -- vim.api.nvim_set_hl(0, "NavbuddyScope", { bg = "#535C6A" })
  -- vim.api.nvim_set_hl(0, "NavbuddyName", { fg = "#DCD7BA", bg = "#FFA066" })
  navbuddy.setup({
    window = {
      border = "rounded", -- "rounded", "double", "solid", "none"
      size = { height = "90%", width = "90%" }, -- Or table format example: { height = "51%", width = "100%"}
      -- size = { height = "70%", width = "60%" }, -- Or table format example: { height = "51%", width = "100%"}
      -- position = "100%",                         -- Or table format example: { row = "100%", col = "0%"}
      sections = {
        left = {
          size = "20%",
          border = "rounded", -- You can set border style for each section individually as well.
        },
        mid = {
          size = "35%",
          border = "solid",
        },
        right = {
          -- No size option for right most section. It fills to
          -- remaining area.
          -- border = "rounded",
          preview = "always", -- Right section can show previews too.
        },
      },
    },
    lsp = {
      auto_attach = true, -- If set to true, you don't need to manually use attach function
    },
    custom_hl_group = "Visual", -- "Visual" or any other hl group to use instead of inverted colors
    source_buffer = {
      follow_node = false, -- Keep the current node in focus on the source buffer
      highlight = true, -- Highlight the currently focused node
      reorient = "smart", -- "smart", "top", "mid" or "none"
      scrolloff = nil, -- scrolloff value when navbuddy is open
    },
  })
end
return M

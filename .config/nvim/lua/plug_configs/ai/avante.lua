local M = { "yetone/avante.nvim", event = "VeryLazy", lazy = false, opts = {}, build = "make", version = false }

M.dependencies = {
  "stevearc/dressing.nvim",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = { file_types = { "markdown", "Avante" } },
    ft = { "markdown", "Avante" },
  },
}

M.config = function()
  require("avante").setup({
    provider = "deepseek",
    hints = { enabled = false },
    vendors = {
      ---@type AvanteProvider
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "VSEGPT_API_KEY",
        endpoint = "https://api.vsegpt.ru/v1",
        model = "deepseek/deepseek-chat",
        -- model = "deepseek/deepseek-r1-distill-llama-70b",
        disable_tools = true,
        max_tokens = 2048,
      },
    },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 40, -- default % based on available width
      sidebar_header = {
        enabled = true, -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
    },
    mappings = {
      ---@class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      ask = "<leader>qa",
      edit = "<leader>qe",
      refresh = "<leader>qr",
      toggle = {
        default = "<leader>qt",
        debug = "<leader>qd",
        hint = "<leader>qh",
        suggestion = "<leader>qs",
      },
    },
  })
end
return M

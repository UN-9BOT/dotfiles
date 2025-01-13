local M = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- { "andersevenrud/nvim_context_vt" },
    { "dariuscorvus/tree-sitter-language-injection.nvim", opts = {}, event = { "BufReadPre" } }, -- for injections
    {
      "RRethy/nvim-treesitter-textsubjects",
      config = function()
        require("nvim-treesitter.configs").setup({
          textsubjects = {
            enable = true,
            prev_selection = ",", -- (Optional) keymap to select the previous selection
            keymaps = {
              ["."] = "textsubjects-smart",
              [";"] = "textsubjects-container-outer",
              ["i;"] = { "textsubjects-container-inner", desc = "Select inside containers (classes, functions, etc.)" },
            },
          },
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup({
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 1, -- Maximum number of lines to show for a single context
          trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20, -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
      end,
    },
  },
}

M.config = function()
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldlevelstart = 99 -- load buffers with folds open
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
    matchup = {
      enable = true, -- mandatory, false will disable the whole extension
      disable = { "c", "ruby" }, -- optional, list of language that will be disabled
      -- [options]
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["ic"] = "@comment.inner",
          ["ac"] = "@comment.outer",
          -- You can optionally set descriptions to the mappings (used in the desc parameter of
          -- nvim_buf_set_keymap) which plugins like which-key display
          -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- ["ac"] = "@class.outer",
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = true,
      },
    },
  })

  vim.keymap.set("n", "<M-t>", function()
    if vim.b.ts_highlight then
      vim.treesitter.stop()
    else
      vim.treesitter.start()
    end
  end, { desc = "Toggle Treesitter Highlight" })
end

return M

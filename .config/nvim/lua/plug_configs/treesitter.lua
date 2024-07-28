local M = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
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
          ["ic"] = "@conditional.inner",
          ["ac"] = "@conditional.outer",
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

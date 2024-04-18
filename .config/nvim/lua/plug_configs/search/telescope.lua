---@diagnostic disable: undefined-global
-- TODO: переехать на live_grep_args
local M = {
  "nvim-telescope/telescope.nvim",
}

M.dependencies = {
  "kkharji/sqlite.lua", -- for other dependencies

  {
    "prochri/telescope-all-recent.nvim", -- frecency sorting for Find files
    config = function()
      require("telescope-all-recent").setup({
        pickers = {
          find_files = {
            disable = false,
            use_cwd = true,
            sorting = "frecency",
          },
        },
      })
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
}

M.config = function()
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }
  local actions = require("telescope.actions")
  local builtin = require("telescope.builtin")
  local lga_actions = require("telescope-live-grep-args.actions")
  local trouble = require("trouble.providers.telescope")
  local u = require("plug_configs.search.utils")


  local _n = { "n" }
  local nv = { "n", "v" }
  b(_n, ",,", builtin.resume, opts)
  b(nv, ",l", builtin.oldfiles, opts)
  b(_n, ",g", builtin.live_grep, opts)
  b(_n, ",f", builtin.find_files, opts)
  b(nv, ",v", builtin.grep_string, opts)
  b(nv, ",b", builtin.git_bcommits_range, opts)
  b(_n, ",S", builtin.lsp_dynamic_workspace_symbols, opts)
  b(_n, ",G", require("telescope").extensions.live_grep_args.live_grep_args, opts)

  require("telescope").setup({
    defaults = {
      path_display = { "absolute" },
      file_ignore_patterns = u.file_ignore_patterns,
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-h>"] = actions.file_split,
          ["<C-v>"] = actions.file_vsplit,
          ["<c-q>"] = trouble.open_with_trouble,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<C-h>"] = actions.file_split,
          ["<C-v>"] = actions.file_vsplit,
          ["<c-q>"] = trouble.open_with_trouble,
        },
      },
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.5,
          results_width = 0.5,
        },
        width = 0.95,
        height = 0.95,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = ' -g "!tests/*" ' }),
          },
        },
      }
    },
    pickers = {
      find_files = {
        sorting = "frecency",
      },
    },
  })
  vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number") -- line number in previeew mode
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("live_grep_args")
end

return M

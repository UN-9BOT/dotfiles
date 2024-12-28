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
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "scottmckendry/telescope-resession.nvim" },
}

M.config = function()
  local actions = require("telescope.actions")
  local builtin = require("telescope.builtin")
  local lga_actions = require("telescope-live-grep-args.actions")
  local lga_shortucts = require("telescope-live-grep-args.shortcuts")
  local trouble = require("trouble.sources.telescope")
  local u = require("plug_configs.search.utils")

  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }
  b({ "n", "v" }, ",v", builtin.grep_string, opts)
  -- b({ "n", "v" }, ",v", u._add_buf_name(lga_shortucts.grep_word_under_cursor), opts)
  -- b({ "n", "v" }, ",b", builtin.git_bcommits_range, opts)
  b("n", ",,", builtin.resume, opts)
  b("n", ",l", builtin.oldfiles, opts)
  b("n", ",o", builtin.jumplist, opts)
  b("n", ",G", builtin.live_grep, opts)
  b("n", ",f", builtin.find_files, opts)
  b("n", ",SS", builtin.lsp_dynamic_workspace_symbols, opts)
  b("n", ",Ss", builtin.lsp_document_symbols, opts)
  -- b("n", ",g", require("telescope").extensions.live_grep_args.live_grep_args, opts)
  b("n", ",g", u._add_buf_name(require("telescope").extensions.live_grep_args.live_grep_args), opts)

  require("telescope").setup({
    defaults = {
      -- path_display = { "absolute" },
      path_display = { "filename_first" },
      file_ignore_patterns = u.file_ignore_patterns,
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-h>"] = actions.file_split,
          ["<C-v>"] = actions.file_vsplit,
          ["<C-q>"] = trouble.open,
          ["<A-q>"] = trouble.open,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<C-h>"] = actions.file_split,
          ["<C-v>"] = actions.file_vsplit,
          ["<C-q>"] = trouble.open,
          ["<A-q>"] = trouble.open,
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
      resession = {
        prompt_title = "Find Sessions", -- telescope prompt title
        dir = "session", -- directory where resession stores sessions
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-o>"] = lga_actions.quote_prompt({ postfix = ' -g "!tests/*" ' }),
            ["<F1>"] = lga_actions.quote_prompt({ postfix = ' -g "!tests/*" ' }),
            -- ["<F2>"] = u.__find_lib(),
            ["<F2>"] = u.LGA:find_lib(),
            ["<C-space>"] = actions.to_fuzzy_refine,
            ["<tab>"] = actions.toggle_selection + actions.move_selection_previous,
          },
        },
      },
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
  require("telescope").load_extension("attempt")

  local my_find_files
  my_find_files = function(opts, no_ignore)
    opts = opts or {}
    no_ignore = vim.F.if_nil(no_ignore, false)
    opts.attach_mappings = function(_, map)
      map({ "n", "i" }, "<C-z>", function(prompt_bufnr) -- <C-h> to toggle modes
        local prompt = require("telescope.actions.state").get_current_line()
        require("telescope.actions").close(prompt_bufnr)
        no_ignore = not no_ignore
        my_find_files({ default_text = prompt }, no_ignore)
      end)
      return true
    end

    if no_ignore then
      opts.no_ignore = true
      opts.hidden = true
      opts.prompt_title = "Find Files <ALL>"
      require("telescope.builtin").find_files(opts)
    else
      opts.prompt_title = "Find Files"
      require("telescope.builtin").find_files(opts)
    end
  end
  local my_live_grep
  my_live_grep = function(opts, no_ignore)
    opts = opts or {}
    no_ignore = vim.F.if_nil(no_ignore, false)
    opts.attach_mappings = function(_, map)
      map({ "n", "i" }, "<C-z>", function(prompt_bufnr) -- <C-h> to toggle modes
        local prompt = require("telescope.actions.state").get_current_line()
        require("telescope.actions").close(prompt_bufnr)
        no_ignore = not no_ignore
        my_live_grep({ default_text = prompt }, no_ignore)
      end)
      return true
    end

    if no_ignore then
      opts.no_ignore = true
      opts.hidden = true
      opts.prompt_title = "Live Grep <ALL>"
      require("telescope.builtin").live_grep(opts)
    else
      opts.prompt_title = "Live Grep"
      require("telescope.builtin").live_grep(opts)
    end
  end

  -- vim.keymap.set("n", ",w", my_find_files) -- you can then bind this to whatever you want
  -- vim.keymap.set("n", ",e", my_live_grep) -- you can then bind this to whatever you want
end

return M

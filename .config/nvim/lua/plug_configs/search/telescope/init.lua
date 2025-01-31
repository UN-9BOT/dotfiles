local M = {
  "nvim-telescope/telescope.nvim",
}

M.dependencies = {
  { "kkharji/sqlite.lua" },
  { "nvim-lua/plenary.nvim" },
  {
    "prochri/telescope-all-recent.nvim", -- frecency sorting for Find files
    config = function()
      require("telescope-all-recent").setup({
        pickers = { find_files = { disable = false, use_cwd = true, sorting = "frecency" } },
      })
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "scottmckendry/telescope-resession.nvim" },
  { "piersolenski/telescope-import.nvim" },
  { "jmacadie/telescope-hierarchy.nvim" },

  -- {
  --   "tanvirtin/vgit.nvim",
  --   branch = "v1.0.x",
  --   -- or               , tag = 'v1.0.1',
  --   dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  --   -- Lazy loading on 'VimEnter' event is necessary.
  --   event = "VimEnter",
  --   config = function()
  --     require("vgit").setup()
  --   end,
  -- },
}
M.keys = {
  {
    "<leader>si",
    "<cmd>Telescope hierarchy incoming_calls<cr>",
    desc = "LSP: [S]earch [I]ncoming Calls",
  },
  {
    "<leader>so",
    "<cmd>Telescope hierarchy outgoing_calls<cr>",
    desc = "LSP: [S]earch [O]utgoing Calls",
  },
}

M.config = function()
  local actions = require("telescope.actions")
  local builtin = require("telescope.builtin")
  local lga_actions = require("telescope-live-grep-args.actions")
  local lga_shortucts = require("telescope-live-grep-args.shortcuts")
  local live_grep_args_ext = require("telescope").extensions.live_grep_args
  local trouble = require("trouble.sources.telescope")
  local u = require("plug_configs.search.telescope.utils")
  local my_find_files
  my_find_files = function(opts, no_ignore)
    opts = opts or {}
    no_ignore = vim.F.if_nil(no_ignore, false)
    opts.attach_mappings = function(_, map)
      map({ "n", "i" }, "<M-a>", function(prompt_bufnr) -- <C-h> to toggle modes
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

  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }

  b({ "n", "v" }, ",v", lga_shortucts.grep_word_under_cursor, opts)
  b("n", ",,", builtin.resume, opts)
  b("n", ",l", builtin.oldfiles, opts)
  b("n", ",o", builtin.jumplist, opts)
  -- b("n", ",f", builtin.find_files, opts)
  b("n", ",f", my_find_files, opts)
  b("n", ",SS", builtin.lsp_dynamic_workspace_symbols, opts)
  b("n", ",Ss", builtin.lsp_document_symbols, opts)
  b("n", ",g", live_grep_args_ext.live_grep_args, opts)

  -- b("n", ",g", require("telescope").extensions.live_grep_args.live_grep_args, opts)

  local action_state = require("telescope.actions.state")

  -- Функция для получения списка доступных флагов (исключая уже выбранные)
  local function get_available_completions(current_input)
    -- Список всех возможных флагов
    local all_options = {
      "no-ignore -.",
      "no-ignore",
      "hidden",
      "case-sensitive",
      "ignore-case",
      "word-regexp",
      "fixed-strings",
    }
    local used_flags = {}

    -- Ищем уже введенные флаги с префиксом `--`
    for flag in current_input:gmatch("%-%-(%S+)") do
      used_flags[flag] = true
    end

    local available_flags = {}
    for _, option in ipairs(all_options) do
      if not used_flags[option] then
        table.insert(available_flags, option)
      end
    end
    return available_flags
  end

  -- Флаг для отслеживания состояния автокомплита
  --- TESTS

  local actions_layout = require("telescope.actions.layout")
  require("telescope").setup({
    defaults = {
      -- path_display = { "absolute" },
      path_display = { "filename_first" },
      file_ignore_patterns = u.file_ignore_patterns,
      mappings = {
        i = {
          ["<M-e>"] = function(_)
            local prompt = action_state.get_current_line()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)[2] + 1
            local before_cursor = prompt:sub(1, cursor_pos)

            if before_cursor:match("%s?%-%-%S*$") then
              local completions = get_available_completions(before_cursor)
              if #completions > 0 then
                vim.fn.complete(cursor_pos, completions)
              end
            end
          end,
          -- ["<esc>"] = actions.close,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-q>"] = trouble.open,
          ["<A-q>"] = trouble.open,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-y>"] = actions_layout.toggle_preview,
        },
        n = {
          -- ["<esc>"] = actions.close,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-q>"] = trouble.open,
          ["<A-q>"] = trouble.open,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-y>"] = actions_layout.toggle_preview,
        },
      },
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.55,
          results_width = 0.45,
        },
        width = 0.99,
        height = 0.98,
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
        auto_quoting = false, -- enable/disable auto-quoting
        mappings = {
          i = {
            ["<M-e>"] = function(_)
              local prompt = action_state.get_current_line()
              local cursor_pos = vim.api.nvim_win_get_cursor(0)[2] + 1
              local before_cursor = prompt:sub(1, cursor_pos)

              if before_cursor:match("%s?%-%-%S*$") then
                local completions = get_available_completions(before_cursor)
                if #completions > 0 then
                  vim.fn.complete(cursor_pos, completions)
                end
              end
            end,
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-o>"] = lga_actions.quote_prompt({ postfix = ' -g "!tests/*" ' }),
            ["<F1>"] = lga_actions.quote_prompt({ postfix = ' -g "!tests/*" ' }),
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
  require("telescope").load_extension("import")
  require("telescope").load_extension("textcase")
  require("telescope").load_extension("hierarchy")

  -- require("plug_configs.python_boosted")
  -- vim.api.nvim_create_user_command("T1T", t.tpicc, {})
end

M._api_impl = {
  ---@param jump_type "never" | "split" | "vsplit" | "tab"
  ---@return function
  reference = function(jump_type)
    return function()
      require("telescope.builtin").lsp_references({ jump_type = jump_type, reuse_win = false })
    end
  end,
  ---@param jump_type "never" | "split" | "vsplit" | "tab"
  ---@return function
  definition = function(jump_type)
    return function()
      require("telescope.builtin").lsp_definitions({ jump_type = jump_type, reuse_win = false })
    end
  end,
  ---@param jump_type "never" | "split" | "vsplit" | "tab"
  ---@return function
  type_definition = function(jump_type)
    return function()
      require("telescope.builtin").lsp_type_definitions({ jump_type = jump_type, reuse_win = false })
    end
  end,
  ---@param jump_type "never" | "split" | "vsplit" | "tab"
  ---@return function
  incoming_calls = function(jump_type)
    return function()
      require("telescope.builtin").lsp_incoming_calls({ jump_type = jump_type })
    end
  end,
  ---@param jump_type "never" | "split" | "vsplit" | "tab"
  ---@return function
  outgoing_calls = function(jump_type)
    return function()
      require("telescope.builtin").lsp_outgoing_calls({ jump_type = jump_type })
    end
  end,
  ---@param jump_type "never" | "split" | "vsplit" | "tab"
  ---@return function
  implementation = function(jump_type)
    return function()
      require("telescope.builtin").lsp_implementations({ jump_type = jump_type, reuse_win = false })
    end
  end,
}

return M

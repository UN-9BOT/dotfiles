---@diagnostic disable: undefined-global
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
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
  },
}

M.config = function()
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }
  local actions = require("telescope.actions")
  local builtin = require("telescope.builtin")
  local previewers = require("telescope.previewers")
  local trouble = require("trouble.providers.telescope")

  -- local def_mapping = { i = { ["<esc>"] = actions.close, ["<cr>"] = "select_tab", } }
  local def_mapping = {
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
  }
  local delta = previewers.new_termopen_previewer({
    get_command = function(entry)
      return {
        "git",
        "-c",
        "core.pager=delta",
        "-c",
        "delta.side-by-side=false",
        "blame",
        entry.value .. "^!",
        "--",
        entry.current_file,
      }
    end,
  })

  b("n", ",f", "<CMD>Telescope find_files<CR>", opts)
  b("n", ",g", builtin.live_grep, opts)
  -- TODO: переехать на live_grep_args 
  -- visual https://github.com/fdschmidt93/dotfiles/blob/526fa21bace17a1121edaeb286847baccdaa3d6b/nvim/.config/nvim/lua/plugins/telescope/init.lua#L192-L211
  -- https://github.com/fdschmidt93/dotfiles/blob/526fa21bace17a1121edaeb286847baccdaa3d6b/nvim/.config/nvim/lua/fds/utils/init.lua#L10
  -- https://github.com/fdschmidt93/dotfiles/blob/526fa21bace17a1121edaeb286847baccdaa3d6b/nvim/.config/nvim/lua/plugins/telescope/init.lua#L192-L211
  -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim?tab=readme-ov-file#shortcut-functions
  b("n", ",G", require("telescope").extensions.live_grep_args.live_grep_args, opts)
  b("n", ",,", builtin.resume, opts)
  b({ "n", "v" }, ",v", builtin.grep_string, opts)
  b({ "n", "v" }, ",r", builtin.registers, opts)
  -- b({ "n", "v" }, ",m", builtin.marks, opts)
  b({ "n", "v" }, ",l", builtin.oldfiles, opts)
  -- b("n", "<c-f>", builtin.current_buffer_fuzzy_find, opts)
  b("n", "<c-f>", "<CMD>Spectre<CR>", opts)
  b("n", ",j", builtin.jumplist, opts)
  b("n", ",J", "<CMD> clearjumps<CR>", { noremap = true })
  M.my_git_bcommits = function(opts)
    opts = opts or {}
    opts.previewer = {
      delta,
      previewers.git_commit_message.new(opts),
      previewers.git_commit_diff_as_was.new(opts),
    }

    builtin.git_bcommits_range(opts)
  end
  -- b({ "n", "v" }, ",b", M.my_git_bcommits)
  b({ "n", "v" }, ",b", builtin.git_bcommits_range)

  local telescope = require("telescope").setup({
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "static",
        "assets/**",
        "assets/",
        "*/assets",
        "%.json",
        "%.js",
        "site-packages",
        "site-packages/*",
        "site-packages/%",
        "docs/",
        "poetry.lock",
        "%.class$",
        "%.dmg$",
        "%.pyc$",
        "%.pyi$",
        "%.tar",
        "%.zip$",
        "^.dart_tool/",
        "^.git/",
        "^.github/",
        "^.gradle/",
        "^.idea/",
        "^.settings/",
        "^.vscode/",
        "^.env/",
        "^__pycache__/",
        "^bin/",
        "^build/",
        "^env/",
        "^gradle/",
        "^node_modules/",
        "^obj/",
        "^target/",
        "^vendor/",
        "^zig%-cache/",
        "^zig%-out/",
        "%.html",
        -- "migrations",
        -- "tests/",
      },
      -- mappings = {
      -- 	i = { ["<c-t>"] = trouble.open_with_trouble },
      -- 	n = { ["<c-t>"] = trouble.open_with_trouble },
      -- }
    },
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
    pickers = {
      find_files = {
        -- layout_config = { height = 0.9, width = 0.9 },
        -- theme = "ivy",
        -- previewer = false,
        sorting = "frecency",
        mappings = def_mapping,
        -- path = "%:p:h"
        grouped = true,
      },
      live_grep = {
        -- layout_config = {
        -- 	anchor = "N",
        -- 	height = 0.50,
        -- 	mirror = true,
        -- 	width = 0.95,
        -- },
        -- theme = "dropdown",
        mappings = def_mapping,
      },
      lsp_references = {
        -- layout_config = {
        -- 	anchor = "N",
        -- 	height = 0.50,
        -- 	mirror = true,
        -- 	width = 0.95,
        -- },
        -- theme = "dropdown",
        mappings = def_mapping,
      },
      git_bcommits_range = {
        layout_config = {
          anchor = "N",
          height = 0.30,
          mirror = true,
          width = 0.95,
        },
        theme = "dropdown",
        mappings = def_mapping,
      },
      grep_string = {
        -- layout_config = {
        -- 	anchor = "N",
        -- 	height = 0.30,
        -- 	mirror = true,
        -- 	width = 0.95,
        -- },
        -- theme = "dropdown",
        mappings = def_mapping,
      },
      registers = {
        -- theme = "dropdown",
        mappings = def_mapping,
      },
      current_buffer_fuzzy_find = {
        -- layout_config = {
        -- 	anchor = "N",
        -- 	height = 0.30,
        -- 	mirror = true,
        -- 	width = 0.95,
        -- },
        -- theme = "dropdown",
        mappings = def_mapping,
      },
      jumplist = {
        -- layout_config = {
        -- 	anchor = "N",
        -- 	height = 0.30,
        -- 	mirror = true,
        -- 	width = 0.95,
        -- },
        -- theme = "dropdown",
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<CR>"] = "select_tab",
          },
        },
      },
    },
  })
  vim.api.nvim_create_augroup("WhichKeyTelescope", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "Trouble",
    callback = function(event)
      local bufopts = { noremap = true, silent = true, buffer = event.buf }
      local trouble_config = require("trouble.config")

      if trouble_config.options.mode == "telescope" then -- TODO: переделать под glance
        vim.keymap.set("n", "D", function()
          require("trouble.providers.telescope").results = {}
          require("trouble").close()
        end, bufopts)

        local delete_entry = function()
          local win = vim.api.nvim_get_current_win()
          local cursor = vim.api.nvim_win_get_cursor(win)
          local line = cursor[1]
          -- Can use Trouble.get_items()
          local results = require("trouble.providers.telescope").results
          local folds = require("trouble.folds")

          local filenames = {}
          for _, result in ipairs(results) do
            if filenames[result.filename] == nil then
              filenames[result.filename] = 1
            else
              filenames[result.filename] = 1 + filenames[result.filename]
            end
          end

          local index = 1
          local cursor_line = 1
          local seen_filename = {}
          while cursor_line < line do
            local result = results[index]
            local filename = result.filename

            if seen_filename[filename] == nil then
              seen_filename[filename] = true
              cursor_line = cursor_line + 1

              if folds.is_folded(filename) then
                index = index + filenames[filename]
              end
            else
              cursor_line = cursor_line + 1
              index = index + 1
            end
          end

          local index_filename = results[index].filename
          local is_filename = (seen_filename[index_filename] == nil)

          if is_filename then
            local filtered_results = {}
            for _, result in ipairs(results) do
              if result.filename ~= index_filename then
                table.insert(filtered_results, result)
              end
            end

            require("trouble.providers.telescope").results = filtered_results
          else
            table.remove(results, index)
          end

          if #require("trouble.providers.telescope").results == 0 then
            require("trouble").close()
          else
            require("trouble").refresh({ provider = "telescope", auto = false })
          end
        end

        vim.keymap.set("n", "x", delete_entry, bufopts)
      end
    end,
  })
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("live_grep_args")
end

return M

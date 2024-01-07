---@diagnostic disable: undefined-global
local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "kkharji/sqlite.lua",           -- for other dependencies
        "piersolenski/telescope-import.nvim", -- leader shift i = import
        {
            "prochri/telescope-all-recent.nvim", -- frecency sorting for Find files
            config = function()
                require("telescope-all-recent").setup({
                    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
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
        { "fannheyward/telescope-coc.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        { "fdschmidt93/telescope-egrepify.nvim" },  -- # .тип  ;  > папка  ; & имя файла
    },
}

M.config = function()
    local b = vim.keymap.set
    local opts = { noremap = true, silent = true }
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local previewers = require('telescope.previewers')
    -- local trouble = require("trouble.providers.telescope")
    -- local def_mapping = { i = { ["<esc>"] = actions.close, ["<cr>"] = "select_tab", } }
    local def_mapping = {
        i = {
            ["<esc>"] = actions.close,
            ["<C-s>"] = actions.file_split,
            ["<C-v>"] = actions.file_vsplit,
        },
        n = {
            ["<esc>"] = actions.close,
            ["<C-s>"] = actions.file_split,
            ["<C-v>"] = actions.file_vsplit,
        },
    }
    local map_esc = { i = { ["<esc>"] = actions.close, } }
    local delta = previewers.new_termopen_previewer {
        get_command = function(entry)
            return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'blame', entry.value .. '^!',
                '--', entry.current_file }
        end
    }
    b({ "n", "v" }, ",c", builtin.git_bcommits_range, opts)
    -- b({ "n", "v" }, ",t", builtin.treesitter, opts)

    b("n", ",f", "<CMD>Telescope find_files<CR>", opts)
    b("n", ",g", require "telescope".extensions.egrepify.egrepify, opts)
    b("n", ",G", require('telescope').extensions.live_grep_args.live_grep_args, opts)
    b("n", ",,", builtin.resume, opts)
    b({ "n", "v" }, ",v", builtin.grep_string, opts)
    b({ "n", "v" }, ",r", builtin.registers, opts)
    b({ "n", "v" }, ",m", builtin.marks, opts)
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
    b({ "n", "v" }, ",b", M.my_git_bcommits)
    -- b({ "n", "v" }, ",b", builtin.git_bcommits_range)

    local telescope = require("telescope").setup({
        defaults = {
            file_ignore_patterns = {
                "node_modules",
                "static",
                "assets/**",
                "assets/",
                "*/assets",
                ".json",
                "site-packages",
                "site-packages/*",
                "site-packages/%",
                "docs/",
                "poetry.lock",
                "migrations",
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
                -- "tests/",
                "%.html"
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
            -- media_files = {
            -- 	-- filetypes whitelist
            -- 	-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            -- 	filetypes = { "png", "webp", "jpg", "jpeg", "webm", "pdf" },
            -- 	-- find command (defaults to `fd`)
            -- 	find_cmd = "rg",
            -- },
            fzf = {
                fuzzy = true,       -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            coc = {
                theme = "ivy",
                prefer_locations = true,
            }
        },
        pickers = {
            find_files = {
                -- layout_config = { height = 0.6, width = 0.9 },
                -- theme = "ivy",
                -- previewer = false,
                sorting = "frecency",
                mappings = def_mapping,
                -- path = "%:p:h"
                grouped = true,
            },
            -- marks = {
            -- 	layout_config = { height = 0.4, width = 0.9 },
            -- 	theme = "dropdown",
            -- 	previewer = true,
            -- 	sorting = "frecency",
            -- 	mappings = def_mapping,
            -- 	mark_type = "local"
            -- },
            -- diagnostics = {
            -- 	layout_config = { height = 0.4 },
            -- 	theme = "ivy",
            -- 	previewer = true,
            -- 	sorting = "frecency",
            -- 	bufnr = 0,
            -- 	mappings = def_mapping,
            -- },
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
            -- treesitter = {
            -- 	layout_config = {
            -- 		anchor = "N",
            -- 		height = 0.30,
            -- 		mirror = true,
            -- 		width = 0.95,
            -- 	},
            -- 	theme = "dropdown",
            -- 	mappings = def_mapping,
            -- },
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
                theme = "dropdown",
                mappings = map_esc,
            },
            coc = {
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
                mappings = map_esc,
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
                        ["<CR>"] = "select_tab"
                    },
                },

            }
        },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("import")
    require('telescope').load_extension('coc')
    require("telescope").load_extension("file_browser")
    -- require("telescope").load_extension('media_files')
    require("telescope").load_extension("live_grep_args")
    require("telescope").load_extension("bookmarks")
    require("telescope").load_extension("egrepify")
    require("telescope").load_extension("advanced_git_search")
end


return M

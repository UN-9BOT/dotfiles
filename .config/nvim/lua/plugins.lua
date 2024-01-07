---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    print("lazy just installed, please restart neovim")
    return
end

local function r(name)
    return function()
        require(name).setup()
    end
end

lazy.setup({
    -- -----------------------
    -- NOTE: WITHOUT CONFIG
    -- -----------------------
    --
    { "nvim-lua/plenary.nvim" },                                 -- common utilities
    { "kkharji/sqlite.lua" },                                    -- sqlite for other plugins
    { "farmergreg/vim-lastplace" },                              -- last position in files
    { "tpope/vim-surround" },                                    -- surround ("' [ { }]')  	--> ysiw' | cs'" | ds",
    { "tpope/vim-repeat" },                                      -- repeat for surround
    { "sindrets/diffview.nvim" },                                -- :Diffview
    { "wellle/targets.vim" },                                    -- next for textobjects in( an( {["'
    { "tpope/vim-fugitive" },                                    -- Neogit
    { "RRethy/vim-tranquille" },                                 -- search and highlight without moving the cursor g/
    { "NeogitOrg/neogit",         config = true },               -- leader G
    { "ldelossa/buffertag",       config = r("buffertag") },     -- float name for tab
    { "folke/todo-comments.nvim", config = r("todo-comments") }, -- TODO: WARNING: FIX: XXX: BUG: NOTE:
    { "numToStr/Comment.nvim",    config = r("Comment") },       -- commentary for if (Loop)
    { "ekalinin/Dockerfile.vim" },



    -- -----------------------
    -- NOTE: WITH CONFIG
    -- -----------------------
    --
    require("plugins.asterisk"),           -- * # highlight without next obj
    require("plugins.bookmarks"),
    require("plugins.markdown-preview"),   -- markdown preview :MarkdownPreview
    require("plugins.my_theme"),           -- themes
    -- require("plugins.indent"),               -- indent (отступы)
    require("plugins.rnvimr"),             -- ranger
    require("plugins.neotree"),            -- neotree
    require("plugins.vim_smooth_scroll"),  -- scrolling
    require("plugins.bufferline"),         -- buffers on top
    require("plugins.lualine"),            -- line on bottom
    require("plugins.treesitter"),         -- highlight syntax
    require("plugins.sessions"),           -- session
    require("plugins.telescope"),          -- telescope
    require("plugins.vim_auto_save"),      -- auto-save files
    require("plugins.easymotion"),         -- fast motion
    require("plugins.indent_blankline"),   -- indent blanklin for func
    require("plugins.rainbow_delimiters"), -- rainbow brackets and operators
    require("plugins.nvim_autopairs"),     -- autopairs for brackets
    require("plugins.neogen"),             -- DOC for C
    require("plugins.vim_visual_multi"),   -- multi cursor
    require("plugins.gitsigns"),           -- right sign inline
    require("plugins.lazygit"),            -- leader+l+g
    require("plugins.wilder"),             -- menu vim
    require("plugins.tagbar"),             -- tagbar F8
    require("plugins.codeium"),            -- Codeium AI
    require("plugins.coc"),                -- LSP
    require("plugins.ale"),                -- linters
    require("plugins.trouble"),            -- quickfix, bug-list and other
    require("plugins.dap"),                -- debugger
    require("plugins.dap_ui"),             -- debugger ui
    require("plugins.neotest"),            -- tests ui
    require("plugins.dap_python"),         -- tests ui
    require("plugins.nvim-scrollview"),    -- scroll bar on right
    require("plugins.hlslens"),            -- for navigate in search mode
    require("plugins.spectre"),            -- search and replace
    require("plugins.smart-splits"),       -- navigate for tmux and resize (ctrl -> navigate, alt -> resize)
    require("plugins.vim-matchup"),        -- % match
    require("plugins.notify"),             -- notifications

    -- ----------------------------
    -- NOTE: dependencies
    -- ----------------------------
    require("plugins.nvim-window-picker"), -- window picker for file_browser
    require("plugins.nvim_web_devicons"),  -- for other plugins, extend with icons

    -- ----------------------------
    -- NOTE: IN_PROGRESS
    -- ----------------------------
    --
    {
        "ellisonleao/dotenv.nvim",
        config = function()
            require('dotenv').setup({
                enable_on_load = true, -- will load your .env file upon loading a buffer
                verbose = false,       -- show error notification if .env file is not found and if .env is loaded
            })
        end
    },

    {
        "michaelb/sniprun",
        branch = "master",
        build = "sh install.sh",
        -- do 'sh install.sh 1' if you want to force compile locally
        -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
        config = function()
            require("sniprun").setup({})
            local b = vim.keymap.set
            b({ "n", "v" }, "<leader>rs", ":SnipRun<cr>")
        end,
    },
    {
        "rolv-apneseth/tfm.nvim",
        config = function()
            local tfm = require("tfm")
            -- Set keymap so you can open the default terminal file manager (yazi)
        end,
        keys = {
            {
                "<leader>e",
                function()
                    local tfm = require("tfm")
                    tfm.open(nil, tfm.OPEN_MODE.tabedit)
                end,
                desc = "TFM - new tab",
            },
        },

    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "BufEnter",
        opts = {
            -- add options here
            -- or leave it empty to use the default settings
        },
    },
    -- { "m00qek/baleia.nvim", tag = 'v1.4.0' },
    {
        "aaronhallaert/advanced-git-search.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            -- to show diff splits and open commits in browser
            "tpope/vim-fugitive",
            -- to open commits in browser with fugitive
            "tpope/vim-rhubarb",
            -- optional: to replace the diff from fugitive with diffview.nvim
            -- (fugitive is still needed to open in browser)
            -- "sindrets/diffview.nvim",
        },
    },



    -- ----------------------------
    -- NOTE: ARCHIVE
    -- ----------------------------
    --
    -- { "mgedmin/python-imports.vim" },
    -- tag for import
    -- {
    -- 	"ludovicchabant/vim-gutentags",
    -- 	config = function()
    -- 		require("plugins.gutentags")
    -- 	end,
    -- },
    -- require("plugins.tmux"),
    -- require("plugins.glance"),
    -- require("plugins.ide"),
    -- { "christoomey/vim-tmux-navigator" }, -- tmux navigation for CTRL
    -- { "simeji/winresizer" }, -- resize windows CTRL+e
    -- { "chaoren/vim-wordmotion" }, -- word motion extra (split on parts) NOTE: изменение становятся слишком сложными
    --
    -- { "echasnovski/mini.bufremove", config = r("mini.bufremove") },       -- не актуально. перешел на tabs
    -- {
    -- 	"linux-cultist/venv-selector.nvim",
    -- 	dependencies = {
    -- 		"neovim/nvim-lspconfig",
    -- 		"nvim-telescope/telescope.nvim",
    -- 		"mfussenegger/nvim-dap-python",
    -- 	},
    -- 	opts = {
    -- 		dap_enabled = true, -- makes the debugger work with venv
    -- 	},
    -- },
    -- { "j-hui/fidget.nvim",        config = r("fidget") },     -- заменил на notify
    --
    -- { "dhruvasagar/vim-zoom" },      -- ZOOM (leader shift z)
    -- require("plugins.zen_mode"),     -- убрал так как исопользую "windows" плагин
    -- profiling = {
    -- 	-- Enables extra stats on the debug tab related to the loader cache.
    -- 	-- Additionally gathers stats about all package.loaders
    -- 	loader = false,
    -- 	-- Track each new require in the Lazy profiling tab
    -- 	require = false,
    -- },
    -- require("plugins.marks"),   -- заменил на bookmarks.nvim. Так как нет глоб сохранения
    -- require("plugins.harpoon"),              -- marks for file
    -- require("plugins.floaterm"),  -- не юзаю
    -- require("plugins.dadbod"),               -- vim db and ui  -- не юзаю
    -- require("plugins.windows"),
    -- require("plugins.telekasten"),           -- notes in markdown  -- не юзаю
    -- require("plugins.nvim-treesitter-context"), -- context (leader t c) -- чаще отключаю, а не юзаю
    -- { "jinh0/eyeliner.nvim" },                                -- fast F motion and highlight uniq chars  -- не юзаю
    -- require("plugins.twilight"),             -- highlight in Zoom mode
    -- {
    --     "miversen33/sunglasses.nvim",
    --     config = function()
    --         require("sunglasses").setup({
    --             filter_percent = 0.35,
    --             filter_type = "SHADE",
    --         })
    --     end
    -- },
})

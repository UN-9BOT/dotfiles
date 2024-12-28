local lazy = require("lazy_init").lazy
local u = require("utils")

lazy.setup({
  -- -----------------------
  -- NOTE: WITHOUT CONFIG
  -- -----------------------
  --
  { "nvim-lua/plenary.nvim" }, -- common utilities
  { "kkharji/sqlite.lua" }, -- sqlite for other plug_configs
  { "nanotee/sqls.nvim" }, -- for sql queries
  { "farmergreg/vim-lastplace" }, -- last position in files
  { "wellle/targets.vim" }, -- next for textobjects in( an( {["'  or previous 2ab
  { "tpope/vim-fugitive" }, -- :G
  { "RRethy/vim-tranquille" }, -- search and highlight without moving g/
  { "raimon49/requirements.txt.vim" }, -- for syntax highlight for requirements.txt
  { "RRethy/nvim-align", cmd = { "Align" } }, -- выравнивание
  { "b0o/incline.nvim", config = u.r("incline") }, -- float name for tab
  { "numToStr/Comment.nvim", config = u.r("Comment") }, -- commentary for if (Loop)
  { "nacro90/numb.nvim", config = u.r("numb") }, -- live preview for :{number_line}
  { "andrewferrier/debugprint.nvim", config = u.r("debugprint") }, -- debug print g?v
  { "m-demare/hlargs.nvim", config = u.r("hlargs") }, -- ts based for hl args
  { "stevearc/dressing.nvim", opts = {} }, -- ui for other plug_configs
  { "j-hui/fidget.nvim", opts = {} }, -- ui for lsp-progress
  { "NvChad/nvim-colorizer.lua", config = u.r("colorizer") }, -- color for hex and rgb notation
  { "kazhala/close-buffers.nvim" }, -- autoclose hidden buffers (optimization)
  { "meznaric/key-analyzer.nvim", opts = {} }, --KeyAnalyzer
  { "tpope/vim-surround", dependencies = { "tpope/vim-repeat" } }, -- surround ("' [ { }]')  	-: ysiw' | cs'" | ds"
  { "NStefan002/visual-surround.nvim", config = u.r("visual-surround") }, -- surround visual mode ( [{( )

  -- -----------------------
  -- NOTE: WITH CONFIG
  -- -----------------------
  --
  u.safe_require("plug_configs.navigate.langmapper"), -- langmapper
  u.safe_require("plug_configs.notify"), -- notifications
  u.safe_require("plug_configs.ui.my_theme"), -- themes
  u.safe_require("plug_configs.ui.edgy"), -- ui
  u.safe_require("plug_configs.ui.nvim_web_devicons"), -- for other _configsgins, extend with icons
  u.safe_require("plug_configs.ui.bufferline"), -- buffers / tabs on top
  u.safe_require("plug_configs.ui.bmessages"), -- wrapper for :messages
  u.safe_require("plug_configs.ui.lualine"), -- line on bottom
  u.safe_require("plug_configs.ui.treesitter"), -- highlight syntax
  u.safe_require("plug_configs.ui.nvim-window-picker"), -- window picker for file_browser
  u.safe_require("plug_configs.ui.markdown-preview"), -- markdown preview :MarkdownPreview
  u.safe_require("plug_configs.ui.rainbow_delimiters"), -- rainbow brackets and operators
  u.safe_require("plug_configs.ui.hlchunk"), -- highlight chunk (indent)
  u.safe_require("plug_configs.ui.todo_comments"), -- TODO: WARNING: FIX: XXX: BUG: NOTE:
  u.safe_require("plug_configs.ui.cursorword"), -- cursor word hl underline
  u.safe_require("plug_configs.ui.whichkey"), -- help for keymaps
  u.safe_require("plug_configs.ui.colorful_winsep"), -- colorful winseparation
  u.safe_require("plug_configs.text_tools.neogen"), -- DOC for C (doxygen)
  u.safe_require("plug_configs.text_tools.conform"), -- Autoformat
  u.safe_require("plug_configs.text_tools.multicursor"), -- multi cursor
  u.safe_require("plug_configs.text_tools.autopair"), -- auto pair brackets and quotes (A-e for offset)
  u.safe_require("plug_configs.text_tools.pantran"), -- translate : leader tr
  u.safe_require("plug_configs.text_tools.norm"), -- live command for :Norm
  u.safe_require("plug_configs.text_tools.refactoring"), -- refactoring for languages
  u.safe_require("plug_configs.git.gitsigns"), -- right sign inline
  u.safe_require("plug_configs.git.diffview"), -- Leader+D -- diffview in n/x
  u.safe_require("plug_configs.git.gitblame"), -- git blame
  u.safe_require("plug_configs.git.gitdev"), -- open repos in temp dir
  u.safe_require("plug_configs.linting.nvim_lint"), -- Lint
  u.safe_require("plug_configs.dap.dap"), -- debugger
  u.safe_require("plug_configs.dap.dap_ui"), -- debugger ui
  u.safe_require("plug_configs.dap.dap_python"), -- config dap
  u.safe_require("plug_configs.dap.envfiles"), -- auto load .env files [[:Dotenv : load .env]]
  u.safe_require("plug_configs.dap.neotest"), -- tests ui
  u.safe_require("plug_configs.search.grug"), -- search and replace
  u.safe_require("plug_configs.search.yankbank"), -- yank register ,r
  u.safe_require("plug_configs.search.telescope"), -- telescope
  u.safe_require("plug_configs.search.nvim-rip-substitute"), -- rip substitute
  u.safe_require("plug_configs.search.trouble"), -- quickfix, bug-list and other (telescope ctrl+q :  (x del))
  u.safe_require("plug_configs.navigate.hlslens"), -- for navigate in search mode
  u.safe_require("plug_configs.navigate.vim_smooth_scroll"), -- scrolling
  u.safe_require("plug_configs.navigate.easymotion"), -- fast motion
  u.safe_require("plug_configs.navigate.spider"), -- moving for only word (w e b)
  u.safe_require("plug_configs.navigate.smart-splits"), -- navigate and resize tmux [[ ctrl : navigate, alt : resize ]]
  -- u.safe_require("plug_configs.navigate.vim-matchup"), -- % match
  u.safe_require("plug_configs.navigate.rnvimr"), -- ranger fm
  u.safe_require("plug_configs.navigate.yazi"), -- yazi fm
  u.safe_require("plug_configs.navigate.arrow"), -- marks v2
  u.safe_require("plug_configs.navigate.recall"), -- mark with global save
  u.safe_require("plug_configs.navigate.vim_auto_save"), -- auto-save files
  u.safe_require("plug_configs.navigate.sessions"), -- session
  u.safe_require("plug_configs.lsp.none_ls"), -- custom code actions
  u.safe_require("plug_configs.lsp.nvim_lspconfig"), -- lsp config
  u.safe_require("plug_configs.lsp.navbuddy"), -- lsp navigation
  u.safe_require("plug_configs.ai.supermaven"), -- supermaven AI completion
  u.safe_require("plug_configs.completition.nvim_cmp"), -- completition
  u.safe_require("plug_configs.mason"), -- installer for features

  -- ----------------------------
  -- NOTE: IN_PROGRESS
  -- ----------------------------
  --

  {
    "AndrewRadev/switch.vim",
    vscode = true,
    keys = {
      {
        -- "<leader>sx",
        "-",
        function()
          vim.cmd("Switch")
        end,
        desc = "Switch",
      },
    },

    config = function()
      vim.g.switch_mapping = ""
    end,
  },

  {
    "mizlan/iswap.nvim",
    cmd = { "ISwap", "ISwapWith", "ISwapNode", "ISwapNodeWith" },
    keys = {
      {
        "<leader>ss",
        function()
          vim.cmd("ISwapWith")
        end,
        desc = "Switch current node",
      },
      {
        "<leader>sm",
        function()
          vim.cmd("IMoveNodeWith")
        end,
        desc = "Move current node",
      },
    },
    config = function()
      require("iswap").setup({
        -- The keys that will be used as a selection, in order
        -- ('asdfghjklqwertyuiopzxcvbnm' by default)
        keys = "asdfghjklqwertyuiop123456",

        -- Grey out the rest of the text when making a selection
        -- (enabled by default)
        -- grey = "enabled",

        -- Highlight group for the sniping value (asdf etc.)
        -- default 'Search'
        hl_snipe = "ErrorMsg",

        -- Highlight group for the visual selection of terms
        -- default 'Visual'
        hl_selection = "WarningMsg",

        -- Highlight group for the greyed background
        -- default 'Comment'
        hl_grey = "LineNr",

        -- Post-operation flashing highlight style,
        -- either 'simultaneous' or 'sequential', or false to disable
        -- default 'sequential'
        flash_style = false,

        -- Highlight group for flashing highlight afterward
        -- default 'IncSearch'
        hl_flash = "ModeMsg",

        -- Move cursor to the other element in ISwap*With commands
        -- default false
        move_cursor = true,

        -- Automatically swap with only two arguments
        -- default nil
        autoswap = true,

        -- Other default options you probably should not change:
        debug = nil,
        hl_grey_priority = "1000",
      })
    end,
  },

  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python" }, -- etc
    lazy = true,
    init = function()
      vim.g["conjure#mapping#doc_word"] = false
    end,

    -- Optional cmp-conjure integration
    dependencies = { "PaterJason/cmp-conjure" },
    keys = {
      {
        "\\cr",
        function()
          vim.cmd("ConjurePythonInterrupt")
          vim.cmd("ConjurePythonStop")
          vim.cmd("ConjurePythonStart")
        end,
        desc = "Restart conjure Python client",
      },
    },
  },
  {
    "m-demare/attempt.nvim", -- No need to specify plenary as dependency
    config = function()
      local attempt = require("attempt")
      attempt.setup()

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts = vim.tbl_extend("force", { silent = true }, opts)
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", "<leader>an", function()
        -- vim.cmd.vsplit()
        vim.cmd.tabedit()
        attempt.new_select()
      end) -- new attempt, selecting extension
      map("n", "<leader>ad", attempt.delete_buf) -- delete attempt from current buffer
      map("n", "<leader>ac", attempt.rename_buf) -- rename attempt from current buffer
      map("n", "<leader>al", require("telescope").extensions.attempt.attempt) -- search through attempts
    end,
  },

  {
    "cshuaimin/ssr.nvim",
    config = function()
      require("ssr").setup({
        border = "rounded",
        min_width = 50,
        min_height = 5,
        max_width = 120,
        max_height = 25,
        adjust_window = true,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_confirm = "<cr>",
          replace_all = "<leader><cr>",
        },
      })
      vim.keymap.set({ "n", "x" }, "<leader>fr", function()
        require("ssr").open()
      end)
    end,
  },

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
  -- {
  --   "chrisgrieser/nvim-recorder",
  --   dependencies = "rcarriga/nvim-notify", -- optional
  --   opts = {}, -- required even with default settings, since it calls `setup()`
  --   config = function()
  --     -- default values
  --     require("recorder").setup({
  --       -- Named registers where macros are saved (single lowercase letters only).
  --       -- The first register is the default register used as macro-slot after
  --       -- startup.
  --       slots = { "a", "b" },
  --
  --       mapping = {
  --         startStopRecording = "q",
  --         playMacro = "Q",
  --         switchSlot = "<C-q>",
  --         editMacro = "cq",
  --         deleteAllMacros = "dq",
  --         yankMacro = "yq",
  --         -- ⚠️ this should be a string you don't use in insert mode during a macro
  --         addBreakPoint = "##",
  --       },
  --
  --       -- Clears all macros-slots on startup.
  --       clear = false,
  --
  --       -- Log level used for non-critical notifications; mostly relevant for nvim-notify.
  --       -- (Note that by default, nvim-notify does not show the levels `trace` & `debug`.)
  --       logLevel = vim.log.levels.INFO, -- :help vim.log.levels
  --
  --       -- If enabled, only essential notifications are sent.
  --       -- If you do not use a plugin like nvim-notify, set this to `true`
  --       -- to remove otherwise annoying messages.
  --       lessNotifications = false,
  --
  --       -- Use nerdfont icons in the status bar components and keymap descriptions
  --       useNerdfontIcons = true,
  --
  --       -- Performance optimzations for macros with high count. When `playMacro` is
  --       -- triggered with a count higher than the threshold, nvim-recorder
  --       -- temporarily changes changes some settings for the duration of the macro.
  --       performanceOpts = {
  --         countThreshold = 100,
  --         lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
  --         noSystemClipboard = true, -- remove `+`/`*` from clipboard option
  --         autocmdEventsIgnore = { -- temporarily ignore these autocmd events
  --           "TextChangedI",
  --           "TextChanged",
  --           "InsertLeave",
  --           "InsertEnter",
  --           "InsertCharPre",
  --         },
  --       },
  --
  --       -- [experimental] partially share keymaps with nvim-dap.
  --       -- (See README for further explanations.)
  --       dapSharedKeymaps = false,
  --     })
  --   end,
  -- },
  -- ---------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------

  --[[

  u.safe_require("plug_configs.ai.avante"), -- chat
  u.safe_require("plug_configs.ai.neocodeium"), -- codeium with fast completion
  u.safe_require("plug_configs.dap.sniprun"), -- run code (<F10>)

  --]]
})

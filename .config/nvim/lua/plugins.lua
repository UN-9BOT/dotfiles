local lazy = require("lazy_init").lazy
local u = require("utils")

lazy.setup({
  -- -----------------------
  -- NOTE: WITHOUT CONFIG
  -- -----------------------
  --
  { "nvim-lua/plenary.nvim" },                                         -- common utilities
  { "kkharji/sqlite.lua" },                                            -- sqlite for other plug_configs
  { "nanotee/sqls.nvim" },                                             -- for sql queries
  { "farmergreg/vim-lastplace" },                                      -- last position in files
  { "sindrets/diffview.nvim" },                                        -- :Diffview
  { "wellle/targets.vim" },                                            -- next for textobjects in( an( {["'
  { "tpope/vim-fugitive" },                                            -- :G
  { "RRethy/vim-tranquille" },                                         -- search and highlight without moving the cursor g/
  { "raimon49/requirements.txt.vim" },                                 -- for syntax highlight for requirements.txt
  { "RRethy/nvim-align",              cmd = { "Align" } },             -- выравнивание
  { "b0o/incline.nvim",               config = u.r("incline") },       -- float name for tab
  { "folke/todo-comments.nvim",       config = u.r("todo-comments") }, -- TODO: WARNING: FIX: XXX: BUG: NOTE:
  { "numToStr/Comment.nvim",          config = u.r("Comment") },       -- commentary for if (Loop)
  { "nacro90/numb.nvim",              config = u.r("numb") },          -- live preview for :{number_line}
  { "andrewferrier/debugprint.nvim",  config = u.r("debugprint") },    -- debug print g?v
  { "anuvyklack/pretty-fold.nvim",    config = u.r("pretty-fold") },   -- fold for func and diffview
  { "m-demare/hlargs.nvim",           config = u.r("hlargs") },        -- ts based for hl args
  { "lukas-reineke/virt-column.nvim", config = u.r("virt-column") },   -- virt column narrow style
  { "stevearc/dressing.nvim",         opts = {} },                     -- ui for other plug_configs
  { "j-hui/fidget.nvim",              opts = {} },                     -- ui for lsp-progress
  { "segeljakt/vim-silicon" },                                         --screenshot in visual mode
  {
    "tpope/vim-surround",                                              -- surround ("' [ { }]')  	-: ysiw' | cs'" | ds"
    dependencies = {
      "tpope/vim-repeat",
      { "NStefan002/visual-surround.nvim", config = u.r("visual-surround") }, -- surround visual mode ( [{( )
    },
  },

  -- -----------------------
  -- NOTE: WITH CONFIG
  -- -----------------------
  --
  u.safe_require("plug_configs.nvim-window-picker"),    -- window picker for file_browser
  u.safe_require("plug_configs.notify"),                -- notifications
  u.safe_require("plug_configs.nvim_web_devicons"),     -- for other _configsgins, extend with icons
  u.safe_require("plug_configs.markdown-preview"),      -- markdown preview :MarkdownPreview
  u.safe_require("plug_configs.my_theme"),              -- themes
  u.safe_require("plug_configs.vim_smooth_scroll"),     -- scrolling
  u.safe_require("plug_configs.bufferline"),            -- buffers / tabs on top
  u.safe_require("plug_configs.lualine"),               -- line on bottom
  u.safe_require("plug_configs.treesitter"),            -- highlight syntax
  u.safe_require("plug_configs.sessions"),              -- session
  u.safe_require("plug_configs.telescope"),             -- telescope
  u.safe_require("plug_configs.easymotion"),            -- fast motion
  u.safe_require("plug_configs.indent_blankline"),      -- indent blanklin for func
  u.safe_require("plug_configs.rainbow_delimiters"),    -- rainbow brackets and operators
  u.safe_require("plug_configs.nvim_autopairs"),        -- autopairs for brackets
  u.safe_require("plug_configs.neogen"),                -- DOC for C (doxygen)
  u.safe_require("plug_configs.vim_visual_multi"),      -- multi cursor
  u.safe_require("plug_configs.gitsigns"),              -- right sign inline
  u.safe_require("plug_configs.lazygit"),               -- leader+l+g
  u.safe_require("plug_configs.linting.nvim_lint"),     -- Lint
  u.safe_require("plug_configs.dap.dap"),               -- debugger
  u.safe_require("plug_configs.dap.dap_ui"),            -- debugger ui
  u.safe_require("plug_configs.dap.dap_python"),        -- config dap
  u.safe_require("plug_configs.neotest"),               -- tests ui
  u.safe_require("plug_configs.nvim-scrollview"),       -- scroll bar on right
  u.safe_require("plug_configs.hlslens"),               -- for navigate in search mode
  u.safe_require("plug_configs.spectre"),               -- search and replace
  u.safe_require("plug_configs.smart-splits"),          -- navigate for tmux and resize [[ ctrl : navigate, alt : resize ]]
  u.safe_require("plug_configs.vim-matchup"),           -- % match
  u.safe_require("plug_configs.envfiles"),              -- auto load .env files [[:Dotenv : load .env]]
  u.safe_require("plug_configs.sniprun"),               -- run code (<F10>)
  u.safe_require("plug_configs.spider"),                -- moving for only word (w e b)
  u.safe_require("plug_configs.trouble"),               -- quickfix, bug-list and other (telescope ctrl+q : send to list (x del))
  u.safe_require("plug_configs.vim_auto_save"),         -- auto-save files : проблемы с harpoon
  u.safe_require("plug_configs.bmessages"),             -- wrapper for :messages
  u.safe_require("plug_configs.rnvimr"),                -- ranger
  u.safe_require("plug_configs.mason"),                 -- installer for features
  u.safe_require("plug_configs.recall"),                -- mark with global save
  u.safe_require("plug_configs.close_buffers"),         -- auto close buffers
  u.safe_require("plug_configs.none_ls"),               -- custom code actions
  u.safe_require("plug_configs.lsp.nvim_lspconfig"),    -- lsp config
  u.safe_require("plug_configs.completition.nvim_cmp"), -- completition
  u.safe_require("plug_configs.conform"),               -- Autoformat
  u.safe_require("plug_configs.edgy"),                  -- ui
  u.safe_require("plug_configs.optimization_lsp"),      -- stop unused lsp
  u.safe_require("plug_configs.lsp.hover"),             -- lsp hover in new tab
  u.safe_require("plug_configs.pantran"),               -- translate : leader tr
  -- ----------------------------
  -- NOTE: IN_PROGRESS
  -- ----------------------------

  -- ---------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------

  --[[

  u.safe_require("plug_configs.tagbar"), -- tagbar F8         -- NOTE: не юзаю
  u.safe_require("plug_configs.symbol_usage"), -- usage functions and classes  --TODO: тупит лсп

  --]]
})

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
  {
    "tpope/vim-surround", -- surround ("' [ { }]')  	-: ysiw' | cs'" | ds"
    dependencies = {
      "tpope/vim-repeat",
      { "NStefan002/visual-surround.nvim", config = u.r("visual-surround") }, -- surround visual mode ( [{( )
    },
  },

  -- -----------------------
  -- NOTE: WITH CONFIG
  -- -----------------------
  --
  u.safe_require("plug_configs.ui.my_theme"), -- themes
  u.safe_require("plug_configs.ui.edgy"), -- ui
  u.safe_require("plug_configs.notify"), -- notifications
  u.safe_require("plug_configs.nvim-window-picker"), -- window picker for file_browser
  u.safe_require("plug_configs.nvim_web_devicons"), -- for other _configsgins, extend with icons
  u.safe_require("plug_configs.markdown-preview"), -- markdown preview :MarkdownPreview
  u.safe_require("plug_configs.vim_smooth_scroll"), -- scrolling
  u.safe_require("plug_configs.bufferline"), -- buffers / tabs on top
  u.safe_require("plug_configs.lualine"), -- line on bottom
  u.safe_require("plug_configs.treesitter"), -- highlight syntax
  u.safe_require("plug_configs.sessions"), -- session
  u.safe_require("plug_configs.easymotion"), -- fast motion
  u.safe_require("plug_configs.rainbow_delimiters"), -- rainbow brackets and operators
  u.safe_require("plug_configs.neogen"), -- DOC for C (doxygen)
  u.safe_require("plug_configs.git.gitsigns"), -- right sign inline
  u.safe_require("plug_configs.git.diffview"), -- Leader+D -- diffview in n/x
  u.safe_require("plug_configs.git.gitblame"), -- Leader+D -- diffview in n/x
  u.safe_require("plug_configs.linting.nvim_lint"), -- Lint
  u.safe_require("plug_configs.dap.dap"), -- debugger
  u.safe_require("plug_configs.dap.dap_ui"), -- debugger ui
  u.safe_require("plug_configs.dap.dap_python"), -- config dap
  u.safe_require("plug_configs.dap.envfiles"), -- auto load .env files [[:Dotenv : load .env]]
  u.safe_require("plug_configs.neotest"), -- tests ui
  u.safe_require("plug_configs.multicursor"), -- multi cursor
  u.safe_require("plug_configs.search.hlslens"), -- for navigate in search mode
  u.safe_require("plug_configs.search.grug"), -- search and replace
  u.safe_require("plug_configs.search.yankbank"), -- yank register ,r
  u.safe_require("plug_configs.search.telescope"), -- telescope
  u.safe_require("plug_configs.search.nvim-rip-substitute"), -- rip substitute
  u.safe_require("plug_configs.smart-splits"), -- navigate and resize tmux [[ ctrl : navigate, alt : resize ]]
  u.safe_require("plug_configs.vim-matchup"), -- % match
  u.safe_require("plug_configs.sniprun"), -- run code (<F10>)
  u.safe_require("plug_configs.spider"), -- moving for only word (w e b)
  u.safe_require("plug_configs.trouble"), -- quickfix, bug-list and other (telescope ctrl+q :  (x del))
  u.safe_require("plug_configs.vim_auto_save"), -- auto-save files : проблемы с harpoon
  u.safe_require("plug_configs.bmessages"), -- wrapper for :messages
  u.safe_require("plug_configs.rnvimr"), -- ranger
  u.safe_require("plug_configs.mason"), -- installer for features
  u.safe_require("plug_configs.recall"), -- mark with global save
  u.safe_require("plug_configs.none_ls"), -- custom code actions
  u.safe_require("plug_configs.lsp.nvim_lspconfig"), -- lsp config
  u.safe_require("plug_configs.lsp.navbuddy"), -- lsp navigation
  u.safe_require("plug_configs.completition.nvim_cmp"), -- completition
  u.safe_require("plug_configs.conform"), -- Autoformat
  u.safe_require("plug_configs.pantran"), -- translate : leader tr
  u.safe_require("plug_configs.todo_comments"), -- TODO: WARNING: FIX: XXX: BUG: NOTE:
  u.safe_require("plug_configs.arrow"), -- marks v2
  u.safe_require("plug_configs.ai.supermaven"), -- supermaven AI completion
  u.safe_require("plug_configs.hlchunk"), -- highlight chunk (indent)

  -- ----------------------------
  -- NOTE: IN_PROGRESS
  --
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },
  {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
        },
      })
    end,
  },

  -- ---------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------

  --[[

  u.safe_require("plug_configs.ai.neocodeium"), -- codeium with fa  st completion
  u.safe_require("plug_configs.ai.avante"), -- chat
  u.safe_require("plug_configs.search.spectre"), -- search and replace

  --]]
})

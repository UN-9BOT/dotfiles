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
  { "isak102/ghostty.nvim", config = u.r("ghostty") }, -- ghostty config linting

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
  u.safe_require("plug_configs.text_tools.autopair"), -- auto pair brackets and quotes (A-e for offset)
  u.safe_require("plug_configs.text_tools.pantran"), -- translate : leader tr
  u.safe_require("plug_configs.text_tools.norm"), -- live command for :Norm
  u.safe_require("plug_configs.text_tools.refactoring"), -- refactoring for languages
  u.safe_require("plug_configs.text_tools.nvim-macro"), -- macro recorder
  u.safe_require("plug_configs.text_tools.attempt_buffers"), -- temp buffer
  u.safe_require("plug_configs.text_tools.switch"), -- toggle true / false
  u.safe_require("plug_configs.text_tools.iswap"), -- swap nodes on treesitter
  u.safe_require("plug_configs.text_tools.nvim-rip-substitute"), -- rip substitute
  u.safe_require("plug_configs.text_tools.ssr"), -- struct search and replace
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
  u.safe_require("plug_configs.dap.conjure"), -- runner code
  u.safe_require("plug_configs.search.grug"), -- search and replace
  u.safe_require("plug_configs.search.yankbank"), -- yank register ,r
  u.safe_require("plug_configs.search.telescope.telescope"), -- telescope
  u.safe_require("plug_configs.search.trouble"), -- quickfix, bug-list and other (telescope ctrl+q :  (x del))
  u.safe_require("plug_configs.navigate.hlslens"), -- for navigate in search mode
  u.safe_require("plug_configs.navigate.vim_smooth_scroll"), -- scrolling
  u.safe_require("plug_configs.navigate.easymotion"), -- fast motion
  u.safe_require("plug_configs.navigate.spider"), -- moving for only word (w e b)
  u.safe_require("plug_configs.navigate.smart-splits"), -- navigate and resize tmux [[ ctrl : navigate, alt : resize ]]
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
    "KaitoMuraoka/websearcher.nvim",
    keys = {
      {
        ",w",
        mode = { "n" },
        function()
          require("websearcher").search()
        end,
      },
    },
    config = {
      -- The shell command to use to open the URL.
      -- As an empty string, it defaults to your OS defaults("open" for macOS, "xdg-open" for Linux)
      open_cmd = "",

      -- Specify search engine. Default is Google.
      -- See the search_engine section for currently registered search engines
      search_engine = "Brave",

      -- Use W3M in a floating window. Default is False
      use_w3m = false,

      -- Add custom search_engines.
      -- See the search_engine section for currently registered search engines
    },
  },

  {
    "yochem/jq-playground.nvim",
    opts = {
      cmd = { "gojq" },
    },
  },

  -- ---------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------
  --[[

  u.safe_require("plug_configs.text_tools.multicursor"), -- not used
  --]]
})

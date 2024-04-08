local lazy = require("lazy_init").lazy
local utils = require("utils")
local safe_require = utils.safe_require
local r = utils.r

lazy.setup({
  -- -----------------------
  -- NOTE: WITHOUT CONFIG
  -- -----------------------
  --
  { "nvim-lua/plenary.nvim" }, -- common utilities
  { "kkharji/sqlite.lua" }, -- sqlite for other plug_configs
  { "nanotee/sqls.nvim" }, -- for sql queries
  { "farmergreg/vim-lastplace" }, -- last position in files
  { "sindrets/diffview.nvim" }, -- :Diffview
  { "wellle/targets.vim" }, -- next for textobjects in( an( {["'
  { "tpope/vim-fugitive" }, -- :G
  { "RRethy/vim-tranquille" }, -- search and highlight without moving the cursor g/
  { "raimon49/requirements.txt.vim" }, -- for syntax highlight for requirements.txt
  { "RRethy/nvim-align", cmd = { "Align" } }, -- выравнивание
  { "b0o/incline.nvim", config = r("incline") }, -- float name for tab
  { "folke/todo-comments.nvim", config = r("todo-comments") }, -- TODO: WARNING: FIX: XXX: BUG: NOTE:
  { "numToStr/Comment.nvim", config = r("Comment") }, -- commentary for if (Loop)
  { "nacro90/numb.nvim", config = r("numb") }, -- live preview for :{number_line}
  { "andrewferrier/debugprint.nvim", config = r("debugprint") }, -- debug print g?v
  { "anuvyklack/pretty-fold.nvim", config = r("pretty-fold") }, -- fold for func and diffview
  { "m-demare/hlargs.nvim", config = r("hlargs") }, -- ts based for hl args
  { "lukas-reineke/virt-column.nvim", config = r("virt-column") }, -- virt column narrow style
  { "stevearc/dressing.nvim", opts = {} }, -- ui for other plug_configs
  { "j-hui/fidget.nvim", opts = {} }, -- ui for lsp-progress
  { "segeljakt/vim-silicon" }, --screenshot in visual mode
  {
    "tpope/vim-surround", -- surround ("' [ { }]')  	-: ysiw' | cs'" | ds"
    dependencies = {
      "tpope/vim-repeat",
      { "NStefan002/visual-surround.nvim", config = r("visual-surround") }, -- surround visual mode ( [{( )
    },
  },

  -- -----------------------
  -- NOTE: WITH CONFIG
  -- -----------------------
  --
  safe_require("plug_configs.nvim-window-picker"), -- window picker for file_browser
  safe_require("plug_configs.notify"), -- notifications
  safe_require("plug_configs.nvim_web_devicons"), -- for other _configsgins, extend with icons
  safe_require("plug_configs.markdown-preview"), -- markdown preview :MarkdownPreview
  safe_require("plug_configs.my_theme"), -- themes
  safe_require("plug_configs.vim_smooth_scroll"), -- scrolling
  safe_require("plug_configs.bufferline"), -- buffers / tabs on top
  safe_require("plug_configs.lualine"), -- line on bottom
  safe_require("plug_configs.treesitter"), -- highlight syntax
  safe_require("plug_configs.sessions"), -- session
  safe_require("plug_configs.telescope"), -- telescope
  safe_require("plug_configs.easymotion"), -- fast motion
  safe_require("plug_configs.indent_blankline"), -- indent blanklin for func
  safe_require("plug_configs.rainbow_delimiters"), -- rainbow brackets and operators
  safe_require("plug_configs.nvim_autopairs"), -- autopairs for brackets
  safe_require("plug_configs.neogen"), -- DOC for C (doxygen)
  safe_require("plug_configs.vim_visual_multi"), -- multi cursor
  safe_require("plug_configs.gitsigns"), -- right sign inline
  safe_require("plug_configs.lazygit"), -- leader+l+g
  safe_require("plug_configs.linting.nvim_lint"), -- Lint
  safe_require("plug_configs.dap.dap"), -- debugger
  safe_require("plug_configs.dap.dap_ui"), -- debugger ui
  safe_require("plug_configs.dap.dap_python"), -- config dap
  safe_require("plug_configs.neotest"), -- tests ui
  safe_require("plug_configs.nvim-scrollview"), -- scroll bar on right
  safe_require("plug_configs.hlslens"), -- for navigate in search mode
  safe_require("plug_configs.spectre"), -- search and replace
  safe_require("plug_configs.smart-splits"), -- navigate for tmux and resize [[ ctrl : navigate, alt : resize ]]
  safe_require("plug_configs.vim-matchup"), -- % match
  safe_require("plug_configs.envfiles"), -- auto load .env files [[:Dotenv : load .env]]
  safe_require("plug_configs.sniprun"), -- run code (<F10>)
  safe_require("plug_configs.spider"), -- moving for only word (w e b)
  safe_require("plug_configs.trouble"), -- quickfix, bug-list and other (telescope ctrl+q : send to list (x del))
  safe_require("plug_configs.vim_auto_save"), -- auto-save files : проблемы с harpoon
  safe_require("plug_configs.bmessages"), -- wrapper for :messages
  safe_require("plug_configs.rnvimr"), -- ranger
  safe_require("plug_configs.mason"), -- installer for features
  safe_require("plug_configs.marks"), -- mark with global save
  safe_require("plug_configs.close_buffers"), -- auto close buffers
  safe_require("plug_configs.none_ls"), -- custom code actions
  safe_require("plug_configs.symbol_usage"), -- usage functions and classes
  safe_require("plug_configs.lsp.nvim_lspconfig"), -- lsp config
  safe_require("plug_configs.completition.nvim_cmp"), -- completition
  safe_require("plug_configs.conform"), -- Autoformat
  -- ----------------------------
  -- NOTE: IN_PROGRESS
  -- ----------------------------

  -- ---------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------

  --[[
  safe_require("plug_configs.optimization_lsp"), -- stop unused lsp  -- NOTE: лаги???
  safe_require("plug_configs.coc"),                         -- NOTE: переехал на cmp
  safe_require("plug_configs.trailblazer"),                 -- NOTE: marks ,ma ; ,M : пробую recall
  safe_require("plug_configs.tagbar"), -- tagbar F8         -- NOTE: не юзаю
  --]]
})

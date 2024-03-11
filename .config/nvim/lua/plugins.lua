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
  { "nvim-lua/plenary.nvim" },                                          -- common utilities
  { "kkharji/sqlite.lua" },                                             -- sqlite for other plugins
  { "farmergreg/vim-lastplace" },                                       -- last position in files
  { "tpope/vim-surround" },                                             -- surround ("' [ { }]')  	-: ysiw' | cs'" | ds"
  { "tpope/vim-repeat" },                                               -- repeat for surround
  { "sindrets/diffview.nvim" },                                         -- :Diffview
  { "wellle/targets.vim" },                                             -- next for textobjects in( an( {["'
  { "tpope/vim-fugitive" },                                             -- Neogit
  { "RRethy/vim-tranquille" },                                          -- search and highlight without moving the cursor g/
  { "ekalinin/Dockerfile.vim" },                                        -- сниппеты
  { "vimpostor/vim-tpipeline" },                                        -- join tmux line and vim status line
  { "raimon49/requirements.txt.vim" },                                  -- for syntax highlight for requirements.txt
  { "RRethy/nvim-align",               cmd = { "Align" }, },            -- выравнивание
  { "NeogitOrg/neogit",                config = true },                 -- leader G
  { "b0o/incline.nvim",                config = r("incline") },         -- float name for tab
  { "folke/todo-comments.nvim",        config = r("todo-comments") },   -- TODO: WARNING: FIX: XXX: BUG: NOTE:
  { "numToStr/Comment.nvim",           config = r("Comment") },         -- commentary for if (Loop)
  { "nacro90/numb.nvim",               config = r("numb"), },           -- live preview for :{number_line}
  { "andrewferrier/debugprint.nvim",   config = r("debugprint") },      -- debug print g?v
  { "anuvyklack/pretty-fold.nvim",     config = r("pretty-fold") },     -- fold for markdown
  { "m-demare/hlargs.nvim",            config = r("hlargs") },          -- ts based for hl args
  { "NStefan002/visual-surround.nvim", config = r("visual-surround") }, -- surround visual mode ( [{( )
  { "lukas-reineke/virt-column.nvim",  config = r("virt-column") },     -- virt column narrow style
  { "RaafatTurki/corn.nvim",           config = r("corn") },            -- float diagnostic
  {
    "roobert/hoversplit.nvim",
    config = function()
      require("hoversplit").setup({
        key_bindings = {
          split_remain_focused = ",E",
          -- vsplit_remain_focused = ",F",
          split = "<leader>hhS",
          vsplit = ",F",
          -- split: Opens a horizontal split with hover information, focusing on the split.
          -- vsplit: Opens a vertical split with hover information, focusing on the split.
          -- split_remain_focused: Opens a horizontal split without moving the focus from the original buffer.
          -- vsplit_remain_focused: Opens a vertical split without moving the focus from the original buffer.
        },
      })
    end,
  },



  -- -----------------------
  -- NOTE: WITH CONFIG
  -- -----------------------
  --
  require("plugins.markdown-preview"),   -- markdown preview :MarkdownPreview
  require("plugins.my_theme"),           -- themes
  require("plugins.vim_smooth_scroll"),  -- scrolling
  require("plugins.bufferline"),         -- buffers / tabs on top
  require("plugins.lualine"),            -- line on bottom
  require("plugins.treesitter"),         -- highlight syntax
  require("plugins.sessions"),           -- session
  require("plugins.telescope"),          -- telescope
  require("plugins.easymotion"),         -- fast motion
  require("plugins.indent_blankline"),   -- indent blanklin for func
  require("plugins.rainbow_delimiters"), -- rainbow brackets and operators
  require("plugins.nvim_autopairs"),     -- autopairs for brackets
  require("plugins.neogen"),             -- DOC for C (doxygen)
  require("plugins.vim_visual_multi"),   -- multi cursor
  require("plugins.gitsigns"),           -- right sign inline
  require("plugins.lazygit"),            -- leader+l+g
  require("plugins.wilder"),             -- menu vim
  require("plugins.tagbar"),             -- tagbar F8
  require("plugins.codeium"),            -- Codeium AI
  require("plugins.nvim_lint"),          -- Lint
  require("plugins.dap"),                -- debugger
  require("plugins.dap_ui"),             -- debugger ui
  require("plugins.dap_python"),         -- config dap
  require("plugins.neotest"),            -- tests ui
  require("plugins.nvim-scrollview"),    -- scroll bar on right
  require("plugins.hlslens"),            -- for navigate in search mode
  require("plugins.spectre"),            -- search and replace
  require("plugins.smart-splits"),       -- navigate for tmux and resize [[ ctrl : navigate, alt : resize ]]
  require("plugins.vim-matchup"),        -- % match
  require("plugins.envfiles"),           -- auto load .env files [[:Dotenv : load .env]]
  require("plugins.sniprun"),            -- run code (<F10>)
  require("plugins.spider"),             -- moving for only word (w e b)
  require("plugins.trouble"),            -- quickfix, bug-list and other (telescope ctrl+q : send to list (x del))
  require("plugins.vim_auto_save"),      -- auto-save files : проблемы с harpoon
  require("plugins.trailblazer"),        -- marks ,ma ; ,M
  require("plugins.bmessages"),          -- wrapper for :messages
  require("plugins.rnvimr"),             -- ranger
  require("plugins.mason"),  -- installer for features
  require("plugins.conform"),


  -- ----------------------------
  -- NOTE: dependencies
  -- ----------------------------
  require("plugins.nvim-window-picker"), -- window picker for file_browser
  require("plugins.notify"),             -- notifications
  require("plugins.nvim_web_devicons"),  -- for other plugins, extend with icons


  -- ----------------------------
  -- NOTE: IN_PROGRESS
  -- ----------------------------

  require("plugins.nvim_lspconfig"),
  require("plugins.nvim_cmp"),



  -- ----------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------

  --[[
  { "nvim-zh/colorful-winsep.nvim", config = true, event = { "WinNew" }, }, -- NOTE: color for main window : lags
  { "ldelossa/buffertag",            config = r("buffertag") },             -- NOTE: float name for tab : replace incline

  require("plugins.python_imports"),                                        -- NOTE: импорты из проекта : не юзаю
  require("plugins.marks"),                                                 -- NOTE: метки на полях : заменил на bookmarks.nvim. нет глоб сохранения
  require("plugins.ale"),                                                   -- NOTE: linters : nvim-lint
  require("plugins.neotree"),                                               -- NOTE: file manager, right side, : не юзаю
  require("plugins.coc"),                                                   -- NOTE: переехал на cmp
  --]]
})

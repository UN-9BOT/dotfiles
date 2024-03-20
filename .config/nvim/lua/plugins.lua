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

-- use for init plugin without config
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
  { "nvim-lua/plenary.nvim" }, -- common utilities
  { "kkharji/sqlite.lua" }, -- sqlite for other plugins
  { "nanotee/sqls.nvim" }, -- for sql queries
  { "farmergreg/vim-lastplace" }, -- last position in files
  { "sindrets/diffview.nvim" }, -- :Diffview
  { "wellle/targets.vim" }, -- next for textobjects in( an( {["'
  { "tpope/vim-fugitive" }, -- :G
  { "RRethy/vim-tranquille" }, -- search and highlight without moving the cursor g/
  -- { "vimpostor/vim-tpipeline" }, -- join tmux line and vim status line
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
  require("plugins.markdown-preview"), -- markdown preview :MarkdownPreview
  require("plugins.my_theme"), -- themes
  require("plugins.vim_smooth_scroll"), -- scrolling
  require("plugins.bufferline"), -- buffers / tabs on top
  require("plugins.lualine"), -- line on bottom
  require("plugins.treesitter"), -- highlight syntax
  require("plugins.sessions"), -- session
  require("plugins.telescope"), -- telescope
  require("plugins.easymotion"), -- fast motion
  require("plugins.indent_blankline"), -- indent blanklin for func
  require("plugins.rainbow_delimiters"), -- rainbow brackets and operators
  require("plugins.nvim_autopairs"), -- autopairs for brackets
  require("plugins.neogen"), -- DOC for C (doxygen)
  require("plugins.vim_visual_multi"), -- multi cursor
  require("plugins.gitsigns"), -- right sign inline
  require("plugins.lazygit"), -- leader+l+g
  require("plugins.tagbar"), -- tagbar F8
  require("plugins.codeium"), -- Codeium AI
  require("plugins.nvim_lint"), -- Lint
  require("plugins.dap"), -- debugger
  require("plugins.dap_ui"), -- debugger ui
  require("plugins.dap_python"), -- config dap
  require("plugins.neotest"), -- tests ui
  require("plugins.nvim-scrollview"), -- scroll bar on right
  require("plugins.hlslens"), -- for navigate in search mode
  require("plugins.spectre"), -- search and replace
  require("plugins.smart-splits"), -- navigate for tmux and resize [[ ctrl : navigate, alt : resize ]]
  require("plugins.vim-matchup"), -- % match
  require("plugins.envfiles"), -- auto load .env files [[:Dotenv : load .env]]
  require("plugins.sniprun"), -- run code (<F10>)
  require("plugins.spider"), -- moving for only word (w e b)
  require("plugins.trouble"), -- quickfix, bug-list and other (telescope ctrl+q : send to list (x del))
  require("plugins.vim_auto_save"), -- auto-save files : проблемы с harpoon
  require("plugins.bmessages"), -- wrapper for :messages
  require("plugins.rnvimr"), -- ranger
  require("plugins.mason"), -- installer for features
  require("plugins.marks"), -- mark with global save
  require("plugins.close_buffers"), -- auto close buffers

  -- ----------------------------
  -- NOTE: dependencies
  -- ----------------------------
  require("plugins.nvim-window-picker"), -- window picker for file_browser
  require("plugins.notify"), -- notifications
  require("plugins.nvim_web_devicons"), -- for other plugins, extend with icons

  -- ----------------------------
  -- NOTE: IN_PROGRESS
  -- ----------------------------

  require("plugins.nvim_lspconfig"),
  require("plugins.nvim_cmp"),
  require("plugins.conform"),

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      -- { "ThePrimeagen/refactoring.nvim", config = r("refactoring") },
    },

    config = function()
      local null_ls = require("null-ls")
      null_ls.register({
        name = "add type ignore",
        method = { require("null-ls").methods.CODE_ACTION },
        filetypes = { "python" },
        generator = {
          fn = function()
            return {
              {
                title = "# type: ignore",
                action = function()
                  vim.cmd("normal! A  # type: ignore")
                end,
              },
            }
          end,
        },
      })
      null_ls.register({
        name = "add noqa",
        method = { require("null-ls").methods.CODE_ACTION },
        filetypes = { "python" },
        generator = {
          fn = function()
            return {
              {
                title = "# noqa",
                action = function()
                  vim.cmd("normal! A   virtual# noqa")
                end,
              },
            }
          end,
        },
      })
      null_ls.register({
        name = "blame",
        method = { require("null-ls").methods.CODE_ACTION },
        filetypes = { "python" },
        generator = {
          fn = function()
            return {
              {
                title = "blame",
                action = function()
                  vim.cmd("ToggleBlame virtual")
                end,
              },
            }
          end,
        },
      })
      null_ls.setup({
        sources = {
          -- null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
        },
      })
    end,
  },
  {
    "Wansmer/symbol-usage.nvim",
    event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
      require("symbol-usage").setup({ vt_position = "end_of_line" })
    end,
  },

  {
    "linrongbin16/lsp-progress.nvim",
    config = function()
      require("lsp-progress").setup()
    end,
  },

  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      notifications = true,
    },
  },
  {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  -- ----------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------

  --[[
  { "RaafatTurki/corn.nvim", config = r("corn") },                          -- NOTE: float diagnostic : падает на некоторых буферах
                                                                            
  require("plugins.coc"),                                                   -- NOTE: переехал на cmp
  require("plugins.trailblazer"),                                           -- NOTE: marks ,ma ; ,M : пробую recall
  --]]
})

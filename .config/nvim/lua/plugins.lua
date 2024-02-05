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
  { "ekalinin/Dockerfile.vim" },                               -- сниппеты
  { "NeogitOrg/neogit",         config = true },               -- leader G
  { "ldelossa/buffertag",       config = r("buffertag") },     -- float name for tab
  { "folke/todo-comments.nvim", config = r("todo-comments") }, -- TODO: WARNING: FIX: XXX: BUG: NOTE:
  { "numToStr/Comment.nvim",    config = r("Comment") },       -- commentary for if (Loop)



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
  require("plugins.neogen"),             -- DOC for C
  require("plugins.vim_visual_multi"),   -- multi cursor
  require("plugins.gitsigns"),           -- right sign inline
  require("plugins.lazygit"),            -- leader+l+g
  require("plugins.wilder"),             -- menu vim
  require("plugins.tagbar"),             -- tagbar F8
  require("plugins.codeium"),            -- Codeium AI
  require("plugins.coc"),                -- LSP
  require("plugins.nvim_lint"),       -- Lint
  require("plugins.dap"),             -- debugger
  require("plugins.dap_ui"),          -- debugger ui
  require("plugins.dap_python"),      -- config dap
  require("plugins.neotest"),         -- tests ui
  require("plugins.nvim-scrollview"), -- scroll bar on right
  require("plugins.hlslens"),         -- for navigate in search mode
  require("plugins.spectre"),         -- search and replace
  require("plugins.smart-splits"),    -- navigate for tmux and resize [[ ctrl -> navigate, alt -> resize ]]
  require("plugins.vim-matchup"),     -- % match
  require("plugins.envfiles"),        -- auto load .env files [[:Dotenv -> load .env]]
  require("plugins.sniprun"),         -- run code (<F10>)
  require("plugins.ranger"),          -- new file browser
  require("plugins.spider"),          -- moving for only word (w e b)
  require("plugins.harpoon"),         -- harpoon ;marked_open ;Mark (inside: ;new_tab ;horizontal ;vertical)
  require("plugins.portal"),

  -- ----------------------------
  -- NOTE: dependencies
  -- ----------------------------
  require("plugins.nvim-window-picker"), -- window picker for file_browser
  require("plugins.notify"),             -- notifications
  require("plugins.nvim_web_devicons"),  -- for other plugins, extend with icons

  -- ----------------------------
  -- NOTE: IN_PROGRESS
  -- ----------------------------





  -- ----------------------------
  -- NOTE: ARCHIVE
  -- ----------------------------
  --
  --[[
  { "liuchengxu/vim-clap" },                  -- NOTE: альтернатива Telescope -> :Clap install-binary

  require("plugins.ide"),                     -- NOTE: like ide ->много багов при загрузке
  require("plugins.nvim-treesitter-context"), -- NOTE: context (leader t c) -> чаще отключаю, а не юзаю
  require("plugins.telekasten"),              -- NOTE: notes in markdown  -> не юзаю
  require("plugins.dadbod"),                  -- NOTE: vim db and ui  -> не юзаю
  require("plugins.tmux"),                    -- NOTE: заменил на smart-splits
  require("plugins.python_imports"),          -- NOTE: импорты из проекта -> не юзаю
  require("plugins.indent"),                  -- NOTE: indent (отступы) -> NOTE: не юзабельно, ошибки
  require("plugins.rnvimr"),                  -- NOTE: ranger -> switch to yazi
  require("plugins.neotree"),                 -- NOTE: file manager, right side, -> не юзаю
  require("plugins.windows"),                 -- NOTE: maximaze window -> не юзаю
  require("plugins.floaterm"),                -- NOTE: term -> не юзаю
  require("plugins.vim_auto_save"),           -- NOTE: auto-save files -> проблемы с harpoon
  require("plugins.marks"),                   -- NOTE: метки на полях -> заменил на bookmarks.nvim. Так как нет глоб сохранения
  require("plugins.obsidian"),                -- NOTE: obsidian -> не юзаю
  require("plugins.trouble"),                 -- NOTE: quickfix, bug-list and other -> не юзаю
  require("plugins.ale"),                     -- NOTE: linters -> nvim-lint
  require("plugins.nvim_lspconfig"),
  require("plugins.coq"),
  ]]
})

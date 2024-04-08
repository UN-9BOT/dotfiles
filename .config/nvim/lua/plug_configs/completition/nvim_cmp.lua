local M = { "hrsh7th/nvim-cmp" }

local utils = require("utils")
local cmp_utils = require("plug_configs.completition.utils")

local r = utils.r
local custom_mapping = cmp_utils.custom_mapping

M.dependencies = {
  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",
  "hrsh7th/cmp-nvim-lsp", -- use suggestions from the LSP
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "FelipeLema/cmp-async-path",
  "petertriho/cmp-git",
  "rcarriga/cmp-dap",
  "lukas-reineke/cmp-under-comparator",
  "lukas-reineke/cmp-rg",
  "ray-x/cmp-treesitter",

  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "saadparwaiz1/cmp_luasnip", -- adapter for the snippet engine

  "hrsh7th/cmp-cmdline", -- for command line completion

  "hrsh7th/cmp-nvim-lsp-document-symbol",
  { "Exafunction/codeium.nvim", config = r("codeium") },

  {
    "ray-x/lsp_signature.nvim",
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts) --luacheck: ignore
      require("lsp_signature").setup({ hint_enable = false })
    end,
  },
}

M.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    preselect = cmp.PreselectMode.None,

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000, max_item_count = 20 },
      { name = "nvim_lsp_signature_help", priority = 950, max_item_count = 5 },
      { name = "nvim_lua", priority = 900, max_item_count = 3 },
      { name = "luasnip", priority = 800, max_item_count = 5 },
      { name = "buffer", priority = 700, max_item_count = 5 },
      { name = "async_path", priority = 650, max_item_count = 3 },
    }),
    sorting = {
      comparators = {
        -- require("utils").comparators_tscompae,  -- TODO: проблемы с магическими атрибутами классов
        cmp.config.compare.offset,
        cmp.config.compare.score,
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        require("cmp-under-comparator").under, -- magic method last
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        -- cmp.config.compare.order,
        -- require("copilot_cmp.comparators").prioritize,
      },
    },
    experimental = {
      ghost_text = true,
    },
    formatting = {
      format = require("lspkind").cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        -- show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        symbol_map = {
          Text = "󰉿",
          String = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
          Codeium = "󰚩",
        },
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[Lsp]",
          luasnip = "[LuaSnip]",
          rg = "[Rg]",
          treesitter = "[Treesitter]",
          async_path = "[Path]",
          crates = "[Crates]",
        },
      }),
    },
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      -- ["<esc>"] = cmp.mapping.abort(),
      ["<C-n>"] = cmp.mapping(custom_mapping.next_item.v1(cmp, luasnip), { "i", "s" }),
      ["<C-p>"] = cmp.mapping(custom_mapping.prev_item.v1(cmp, luasnip), { "i", "s" }),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ["<c-space>"] = cmp.mapping.complete(),
      ["<C-x>"] = cmp.mapping(custom_mapping.codeium_complete.v1(cmp), { "i", "s" }), -- NOTE: codeium
      ["<C-r>"] = cmp.mapping(custom_mapping.rg_complete.v1(cmp), { "i", "s" }), -- NOTE: ripgrep
    },
  })
  -- Set configuration for specific filetype.
  cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
  })
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
    }, {
      { name = "buffer", keyword_length = 2 },
    }),
  })
  -- Подстановка скобок к подсказкам, которым это нужно (дополнение для nvim-autopairs)
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  vim.keymap.set("n", "<leader>i", custom_mapping.import.custom, {}) -- auto_import for python
end

return M

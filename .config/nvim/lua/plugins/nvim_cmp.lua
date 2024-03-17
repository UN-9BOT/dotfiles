local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
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

    {
      "ray-x/lsp_signature.nvim",
      config = function(_, opts)
        require("lsp_signature").setup({ hint_enable = false })
      end,
    },
  },
}

M.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()
  local has_words_before = function()
    local unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

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
      { name = "nvim_lsp", priority = 1000, max_item_count = 10 },
      { name = "nvim_lsp_signature_help", priority = 950, max_item_count = 5 },
      { name = "nvim_lua", priority = 900, max_item_count = 3 },
      { name = "luasnip", priority = 800, max_item_count = 5 },
      { name = "buffer", priority = 700, max_item_count = 5 },
      { name = "async_path", priority = 650, max_item_count = 3 },
      -- { name = "codeium", priority = 890 }, -- slow, in individual config (ctrl+x)
      -- { name = "rg" } -- ripgrep  -- slow, in individual config (ctrl+r)
    }),
    sorting = {
      comparators = {
        require("utils").comparators_tscompae,
        cmp.config.compare.offset,
        cmp.config.compare.recently_used,
        cmp.config.compare.score,
        cmp.config.compare.exact,
        cmp.config.compare.kind,
        require("cmp-under-comparator").under, -- magic method last
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
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      -- ["C-<CR>"] = cmp.mapping.confirm({
      --   behavior = cmp.ConfirmBehavior.Insert,
      --   select = true,
      -- }),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ["<c-space>"] = cmp.mapping.complete(),
      -- for codeium
      ["<C-x>"] = cmp.mapping(
        cmp.mapping.complete({
          config = {
            sources = cmp.config.sources({
              { name = "codeium" },
            }),
          },
        }),
        { "i", "s" }
      ),
      -- for cmp-rg

      ["<C-r>"] = cmp.mapping(
        cmp.mapping.complete({
          config = {
            sources = cmp.config.sources({
              { name = "rg", option = { additional_arguments = "--smart-case" } },
            }),
          },
        }),
        { "i", "s" }
      ),
    },
  })
  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = "buffer" },
    }),
  })
  require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
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
  require("cmp").setup.cmdline({ "/", "?" }, {
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
end

return M

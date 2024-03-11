local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp", -- use suggestions from the LSP
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "FelipeLema/cmp-async-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "petertriho/cmp-git",
    "rcarriga/cmp-dap",
    "lukas-reineke/cmp-under-comparator",
    "lukas-reineke/cmp-rg",
    "ray-x/cmp-treesitter",
    "L3MON4D3/LuaSnip", -- snippet engine
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip", -- adapter for the snippet engine

    -- "hrsh7th/cmp-cmdline",  -- for command line completion
  },
}

M.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  cmp.setup({
    -- tell cmp to use Luasnip as our snippet engine
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    enabled = function()
      return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "nvim_lsp_signature_help", priority = 950 },
      { name = "nvim_lua", priority = 900 },
      -- { name = "codeium", priority = 890 },  -- in individual config
      -- { name = "treesitter", priority = 850 },  -- trash
      { name = "luasnip", priority = 800 },
      { name = "buffer", priority = 700 },
      { name = "async_path", priority = 650 },
      -- { name = "rg" } -- ripgrep  -- slow, need in individual config
    }),
    sorting = {
      comparators = {
        -- require("copilot_cmp.comparators").prioritize,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        require("cmp-under-comparator").under, -- magic method last
        cmp.config.compare.kind,
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
        symbol_map = { Codeium = "󰚩", treesitter = " ", luasnip = " 🐍", buffer = "" },
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
        elseif luasnip.choice_active() then
          luasnip.change_choice(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
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
              { name = "rg" },
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
end

return M

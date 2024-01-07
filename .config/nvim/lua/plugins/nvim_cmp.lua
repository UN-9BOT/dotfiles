local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- use suggestions from the LSP
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',

        -- Snippet engine. Required for nvim-cmp to work, even if you don't
        -- intend to use custom snippets.
        "L3MON4D3/LuaSnip",         -- snippet engine
        "saadparwaiz1/cmp_luasnip", -- adapter for the snippet engine
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            -- tell cmp to use Luasnip as our snippet engine
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },
            -- Define the mappings for the completion. The `fallback()` call
            -- ensures that when there is no suggestion window open, the mapping
            -- falls back to the default behavior (adding indentation).
            mappings = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- true = autoselect first entry
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })
    end,
}

return M

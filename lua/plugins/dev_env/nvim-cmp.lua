-- This file sets up auto completion with Ultisnips and others
local function config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local cmp_opts = {
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = {
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-3), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(3), { "i", "c" }),
            ["<C-q>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
        }),
    }

    cmp.setup(cmp_opts)

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = { ignore_cmds = { 'Man', '!' } },
            }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
    })

    -- -- Set up lspconfig.
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    --     capabilities = capabilities
    -- }
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        -- "SirVer/ultisnips",
        -- "quangnguyen30192/cmp-nvim-ultisnips",
        "neovim/nvim-lspconfig",
    },
    config = config,
    version = "*",
}

local function config()
    local luasnip_opts = {      -- Check :h luasnip-config-options
        -- history = true,      -- history option is deprecated.
        updateevents = {"TextChanged", "TextChangedI"},
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
    }

    local luasnip_dir = '~/.config/nvim/LuaSnips/'

    require('luasnip').config.set_config(luasnip_opts)
    require('luasnip.loaders.from_lua').lazy_load({ paths = luasnip_dir })

    vim.cmd([[
    imap <silent><expr> <Tab> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<Tab>' 

    inoremap <silent> <C-l> <cmd>lua require('luasnip').jump(1)<Cr>
    inoremap <silent> <C-h> <cmd>lua require('luasnip').jump(-1)<Cr>
    snoremap <silent> <C-l> <cmd>lua require('luasnip').jump(1)<Cr>
    snoremap <silent> <C-h> <cmd>lua require('luasnip').jump(-1)<Cr>

    imap <silent><expr> <C-j> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-j>'
    smap <silent><expr> <C-j> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-j>'
    imap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-j>'
    smap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-j>'
    ]])

    vim.cmd([[
    silent command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()
    ]])
end

return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = config,
}

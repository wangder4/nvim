-- Define config function
local function config()
    local opts = {
        -- ensure_installed = "all",
        ensure_installed = {
            -- System language
            "bash", "cmake", "make",
            -- Programming language
            "c", "lua", "python", "verilog", "vim",
            -- Marker language
            "json", "latex", "markdown",
            "markdown_inline", "vim", "vimdoc",
        },
        auto_install = true,

        -- if need to change the highlights of an identifier,
        --  check :h treesitter-highlight-groups
        highlight = {
            enable = true,
            -- enable = { "c" },
            -- disable = { "latex" },
            -- disable highlights under conditions
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                -- Disable highlights for latex, VimTex handle this
                if lang == "latex" then
                    return false
                end

                if lang == "python" then
                    return false
                end

                -- Disable highlight if file is too large
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size < max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = { "latex" },
        },
        indent = {
            enable = true,
        }
    }

    require("nvim-treesitter.configs").setup(opts)
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

-- Return the table
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = config,
}

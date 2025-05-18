-- conform.nvim  is a formatter plugin for nvim
-- This setup is inspired by https://www.josean.com/posts/neovim-linting-and-formatting
-- by josean
local function config()
    local conform = require("conform")
    local conform_opt = {
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            svelte = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            -- graphql = { "prettier" },
            -- lua = { "stylua" },
            python = { "black" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    }

    conform.setup(conform_opt)

    vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
            vim.b.disable_autoformat = true
        else
            vim.g.disable_autoformat = true
        end
    end, {
        desc = "Disable autoformat-on-save",
        bang = true,
    })

    -- -- Using conform to set foldexpr
    -- vim.o.foldexpr = "v:lua.require'conform'.formatexpr()"
end

return {
    "stevearc/conform.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    config = config,
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fm",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
}

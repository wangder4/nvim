-- https://adam-coates.github.io/posts/2024-05-09/#neovim-and-mason
-- by Adam Coates

local function lua_ls_conf()
    local lspconfig = require("lspconfig")
    local lua_ls_opts = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        -- vim related APIs
                        "vim",
                        -- Luasnip related APIs
                        "s",     -- snippet
                        "t",     -- text node
                        "c",     -- choice node
                        "i",     -- insert node
                        "f",     -- function node
                        "rep",   -- repeat
                        "fmt",   -- auto format
                        "fmta",  -- auto format with <>
                        "conds", -- luasnip.expand.extra_conditions
                    },
                },
            },
        },
    }

    lspconfig.lua_ls.setup(lua_ls_opts)
end

local function pylsp_conf()
    require 'lspconfig'.pylsp.setup {
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = { 'W391', 'E501', 'W503', 'E203', 'E266' },
                        -- maxLineLength = 100
                    }
                }
            }
        }
    }
end

local function svlangserver_conf()
    local lspconfig = require("lspconfig")
    local svlangserver_opts = {
        on_init = function(client)
            client.config.settings.systemverilog = {
                launchConfiguration = "/tools/verilator -Wall --timing --lint-only",
            }
        end
    }

    lspconfig.svlangserver.setup(svlangserver_opts)
end

local function verible_conf()
    local lspconfig = require("lspconfig")
    local verible_opts = {
        -- Ask verible to search configuration rules
        cmd = { 'verible-verilog-ls', '--rules_config_search' }
    }

    lspconfig.verible.setup(verible_opts)
end

local function clangd_conf()
    local lspconfig = require("lspconfig")
    local clangd_opts = {
        cmd = {
            'clangd',
            -- '--query-driver=/usr/bin**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++',
            '--all-scopes-completion',
            '--background-index',
            '--clang-tidy',
            '--completion-style=detailed',
            '--enable-config',
            '--folding-ranges',
            '--function-arg-placeholders',
            '--header-insertion=iwyu',
            '--header-insertion-decorators',
            '--pch-storage=memory',
            '--malloc-trim',
        }
    }

    lspconfig.clangd.setup(clangd_opts);
end

local function mason_config()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    local mason_opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "-",
                package_uninstalled = "✗"
            },
        },
    }

    local mason_lspconfig_opts = {
        ensure_installed = {
            -- Program languages servers
            "clangd",       -- C, C++
            "lua_ls",       -- lua
            "matlab_ls",    -- matlab
            "pylsp",        -- python
            -- "hdl_checker",  -- System Verilog, verilog, VHDL
            "svlangserver", -- System Verilog
            -- "svls",         -- System Verilog, verilog, * requires cargo, a rust package manager
            "verible",      -- System Verilog, verilog

            "vimls",        -- VimScript
            -- System Used
            "bashls",
            "cmake",
            -- Markup Languages
            "html",
            -- "ltex",      -- Seems less commonly used than texlab
            "texlab",
        },

        automatic_installation = true
    }

    mason.setup(mason_opts)
    mason_lspconfig.setup(mason_lspconfig_opts)

    -- Automatic setup lsp, check :h mason-lspconfig-automatic-server-setup
    mason_lspconfig.setup_handlers {
        -- Default settings
        function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
        -- Specific settings
        ["lua_ls"] = lua_ls_conf,
        ["svlangserver"] = svlangserver_conf,
        ["pylsp"] = pylsp_conf,
        ["clangd"] = clangd_conf,
        ["verible"] = verible_conf,
    }
end

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    version = '*',
    config = mason_config,
}

-- Bootstrap lazy.nvim
-- Trying to clone lazy.nvim if not already exists
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable", -- latest stable release
        lazyrepo,
        lazypath,
    })

    -- Error handling
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
local opts = {
    -- highlight-start
    spec = {
        -- import your plugins
        { import = "plugins.ui" },
        { import = "plugins.tools" },
        { import = "plugins.dev_env" },
        { import = "plugins.dev_env.latex" },
    },
    -- highlight-end

    -- Configuration
    -- *** color scheme that will be used when installing plugins/
    install = { colorscheme = { "habamax" } },
    -- *** automatically check for plugin updates
    checker = { enabled = false },
}

require("lazy").setup(opts)

-- Method from mistgc
-- ref: https://github.com/mistgc/config.nvim/blob/master/lua/bootstrap.lua
-- local plugins_dir_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/plugins/")
-- local plugin_iter = vim.fs.dir(plugins_dir_path)
-- local plugins = {}
--  
-- local function normalize_module_name(filename)
--     for i = 1, #filename do
--         if string.sub(filename, i, i) == "." then
--             return filename:sub(1, i - 1)
--         end
--     end
--     return filename
-- end
-- 
-- for item in plugin_iter do
--     local plugin = require("plugins." .. normalize_module_name(item))
--     table.insert(plugins, plugin)
-- end
-- 
-- require("lazy").setup(plugins)

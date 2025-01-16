local function config()
    local neovim_lspconfig = require("lspconfig")
    local neovim_lspconfig_opts = {
    }
    neovim_lspconfig.setup(neovim_lspconfig_opts)
end

return {
    "neovim/nvim-lspconfig",
    version = "*",
    lazy = true,
    -- config = config,
}

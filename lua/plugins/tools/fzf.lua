local function config()
    local fzf_lua = require("fzf-lua")
    local opts = {
        preview = {
        },
    }

    fzf_lua.setup(opts)
end

return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = config,
}

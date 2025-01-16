local function config()
    local opts = {
        options = {
            icons_enable = true,
            component_separators = { left = '', right = ''},
            section_separators = { left = '>', right = '<'},
        },
    }

    require('lualine').setup(opts)
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = '*',
    config = config,
}

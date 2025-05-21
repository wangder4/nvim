-- Highly recommend reading the following:
-- A good tutorials on ultisnips and latex
--  https://ejmastnak.com/tutorials/vim-latex/

local function init()
    local snip_folder = vim.fn.expand('~/.config/nvim/UltiSnips')

    vim.g.UltiSnipsExpandTrigger = '<Tab>'
    vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
    vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
    vim.g.UltiSnipsSnippetDirectories = {snip_folder}
end

return {
    "SirVer/ultisnips",
    version = "*",
    init = init,
    lazy = false,
}

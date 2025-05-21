local function init()
    --[[ 
    When vim opens a .tex file, it guess the filetype. Therefore, an empty .tex 
    file will be treated as a `plaintex` file by Vim.

    To alter the default behavior, set the tex_flavor to "latex".

    Ref: https://superuser.com/questions/208177/vim-and-tex-filetypes-plaintex-vs-tex
    Answered by: Matthew Rankin
    --]]
    vim.g.tex_flavor = "latex"

    -- Checked https://github.com/lervag/vimtex/issues/3010 for ref
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = 'latexmk'
    -- vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-lualatex" }

    vim.vimtex_syntax_conceal = 1
    vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 1,
        styles = 0,
    }

    vim.g.vimtex_syntax_custom_cmds = {
        { name = 'complement', mathmode = 1, concealchar = '∁'},
        { name = 'O', mathmode = 1, concealchar = '∅'},
        { name = 'R', mathmode = 1, concealchar = 'ℝ'},
        { name = 'Z', mathmode = 1, concealchar = 'ℤ'},
        { name = 'odif', mathmode = 1, concealchar = 'd'},
        { name = 'pdif', mathmode = 1, concealchar = '∂'},
    }

    vim.g.vimtex_quickfix_ignore_filters = {
        'bad break',
    }

    vim.g.vimtex_mappings_enable = 0
    vim.g.imaps_enabled = 0

    -- vim.g.vimtex_quickfix_mode = 1

    -- vim.g.vimtex_view_general_viewer = "okular"
    -- vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
end

return {
    "lervag/vimtex",
    lazy = false,
    version = "*",
    init = init,
    enable=false,
}

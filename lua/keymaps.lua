local function noremap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options);
end

function ToggleCC()
    local enable_txt =
    'colorcolum enabled at column 80, :lua vim.wo.cc = \'80\''
    local disable_txt = 'colorcolum is now disabled'
    if vim.wo.colorcolumn == '' then
        vim.opt.colorcolumn = '80'
        print(enable_txt)
    else
        vim.opt.colorcolumn = ''
        print(disable_txt)
    end
end

-- Basic Mappings
noremap('n', '<Space>w', ':w<CR>')
noremap('n', '<Space>q', ':bd<CR>')
noremap('n', '<Space>b', ':buffers<CR>:b')
noremap('n', '<Space>e', ':b#<CR>')
noremap('n', '<Space>p', ':Explore<CR>')
noremap('n', '<Space><Space>', 'za')
noremap('n', '\\o', '[zv]zzO')
noremap('n', '\\c', '[zv]zzc')
noremap('i', 'jf', '<ESC>')
noremap('c', 'jf', '<ESC>')
-- noremap('n', '<Space>Q', ':qa<CR>')  // Mistyped too much times
-- noremap('i', 'fj', '<ESC>')          // Too much words end with f
-- noremap('c', 'fj', '<ESC>')

-- Utility Mappings
-- *** Temporarily disable search highlights
noremap('n', '\\\\', ':nohlsearch<CR>', { silent = true })
-- *** Toggle colored column
noremap('n', '||', ':lua pcall(ToggleCC)<CR>', { silent = true })
-- *** Toggle spell check
noremap('n', '\\s', ':set spell!<CR>', { silent = true })
-- *** Apply LSP Code Action
noremap('n', '\\ca', ':lua vim.lsp.buf.code_action()<CR>')
-- *** Apply LSP Rename
noremap('v', '\\rn', ":'<,'> lua vim.lsp.buf.rename()<CR>")
-- *** Jump to errors
noremap('n', ']ge', ":lua vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.ERROR, wrap=true})<cr>", { silent = true })
noremap('n', '[ge', ":lua vim.diagnostic.goto_prev( {severity=vim.diagnostic.severity.ERROR, wrap=true})<cr>", { silent = true})
-- *** Jump to errors
noremap('n', ']gw', ":lua vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.WARN, wrap=true})<cr>", { silent = true})
noremap('n', '[gw', ":lua vim.diagnostic.goto_prev( {severity=vim.diagnostic.severity.WARN, wrap=true})<cr>", { silent = true})

-- vim.cmd('nnoremap <Leader>/ /\\C<c-r>=getreg('/')<CR><CR>')
-- noremap('n', '<Leader>/', '/\\C<c-r>=getreg('/')<Cr><Cr>', { silent = true })

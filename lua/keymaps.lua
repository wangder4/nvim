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
vim.keymap.set('n', '<Space>w', ':w<CR>')
vim.keymap.set('n', '<Space>q', ':bd<CR>')
vim.keymap.set('n', '<Space>b', ':buffers<CR>:b')
vim.keymap.set('n', '<Space>e', ':b#<CR>')
vim.keymap.set('n', '<Space>p', ':Explore<CR>')
vim.keymap.set('n', '<Space><Space>', 'za')
vim.keymap.set('i', 'jf', '<ESC>')
vim.keymap.set('c', 'jf', '<ESC>')
vim.keymap.set('t', 'jf', '<C-\\><C-n>')
vim.keymap.set('n', '<Space>o', '[zv]zzO')
vim.keymap.set('n', '<Space>c', '[zv]zzc')

-- Utility Mappings
vim.keymap.set('n', '<CR>', ':nohlsearch<CR>', { desc = 'Disable highlighted search content', silent = true })
vim.keymap.set('n', '||', ':lua pcall(ToggleCC)<CR>', { desc = 'Toggle colored column', silent = true })
vim.keymap.set('n', '\\s', ':set spell!<CR>', { desc = 'Toggle spell check', silent = true })

-- LSP, Diagnstic, DAP
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- *** Apply LSP Code Action
vim.keymap.set('n', '\\ca', ':lua vim.lsp.buf.code_action()<CR>')
-- *** Apply LSP Rename
vim.keymap.set('v', '\\rn', ":'<,'> lua vim.lsp.buf.rename()<CR>")
-- *** Jump to errors
vim.keymap.set('n', ']ge', ":lua vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.ERROR, wrap=true})<cr>",
	{ silent = true })
vim.keymap.set('n', '[ge', ":lua vim.diagnostic.goto_prev( {severity=vim.diagnostic.severity.ERROR, wrap=true})<cr>",
	{ silent = true })
-- *** Jump to errors
vim.keymap.set('n', ']gw', ":lua vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.WARN, wrap=true})<cr>",
	{ silent = true })
vim.keymap.set('n', '[gw', ":lua vim.diagnostic.goto_prev( {severity=vim.diagnostic.severity.WARN, wrap=true})<cr>",
	{ silent = true })

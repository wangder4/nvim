-- This file turns off spell option for a file

-- .core is FuseSoC core file
local ignore_file_patterns = { '.gitignore', '*.core' }
local ignore_filetypes = { 'checkhealth', 'sshconfig' }

-- Define the augroup
local augroup = vim.api.nvim_create_augroup('NoSpellCheck', { clear = true })

-- Function to turn off spell checking
local function disable_spell()
  vim.opt_local.spell = false
end

-- autocmd for .gitignore files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = ignore_file_patterns,
  callback = disable_spell,
  group = augroup,
})

-- autocmd for .gitignore files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = ignore_filetypes,
  callback = disable_spell,
  group = augroup,
})

-- autocmd for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  callback = disable_spell,
  group = augroup,
})

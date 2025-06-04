-- General Options
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true
vim.o.showmode = false -- Displayed in status line already
vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.confirm = true
vim.o.splitright = true
vim.o.splitbelow = true

-- UI setting
vim.o.number = true
vim.o.breakindent = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.signcolumn = "yes"
vim.opt.foldcolumn = "1"
vim.opt.colorcolumn = '80'
vim.opt.foldmethod = 'expr'     -- foldexpr set in lua/plugins/tools/treesitter.lua

-- Tabs
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Searching
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Folding
vim.o.foldlevel = 999
vim.o.foldlevelstart = 99       -- Do not fold anything at first glance
vim.cmd('set foldopen-=search') -- Search don't open fold


-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
vim.opt.wildignore:append { '*.o', '*.a', '__pycache__' }
vim.opt.wildignore:append { '*.pyc', 'node_modules' }
vim.g.wildmode = { 'longest:list' }

-- Timer setting
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time

-- use zg to add new words to local dictionary, use zw to remove it.
vim.o.spell = true
vim.opt.spelllang = { "en", "cjk" }

vim.g.netrw_list_hide = [[.aux$,.o$,.fdb_latexmk$,.fls$,.synctex.gz$,.out$,.log$]]

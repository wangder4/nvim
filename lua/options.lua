local set = vim.opt

-- Compatibility options
set.compatible = false
set.magic = true
set.laststatus = 3
set.showmode = true
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "
vim.g.editorconfig = true
-- vim.o.signcolumn = "yes"
vim.o.signcolumn = "no"

-- Undo options
vim.o.undofile = true
vim.o.undolevels = 10000

-- Visual options
vim.o.inccommand = "split"
set.foldcolumn = '1'
set.number = true
set.numberwidth = 3
set.scrolloff = 5
set.sidescrolloff = 3
set.wrap = false
set.termguicolors = true
set.cursorline = true
set.colorcolumn = '80'
set.foldexpr = "v:lua.require'conform'.formatexpr()"
-- vim.o.list = true
-- vim.opt.listchars = {
--     tab = "▏ ",
--     trail = "·",
--     extends = "»",
--     precedes = "«",
-- }
-- set.previewheight=10

-- Edit options
-- use zg to add new words to local dictionary, use zw to remove it.
set.spell = true
set.spelllang = { "en", "cjk" }

-- Tab options
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

-- Filetype options
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Folding options
vim.o.foldenable = true
vim.o.foldlevel = 999
vim.o.foldlevelstart = 99           -- Do not fold anything at first glance
vim.cmd('set foldopen-=search')     -- Search don't open fold
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo.foldmethod = 'syntax'

-- Search options
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = true
set.wrapscan = true

-- Command-line options
set.wildmenu = true
set.wildignore:append { '*.o', '*.a', '__pycache__'}
set.wildignore:append { '*.pyc', 'node_modules' }
set.wildmode = { 'longest:list' }
set.suffixes = { '.o', '.dvi' , 'bbl'}

-- Window options
-- set.splitbelow = true

-- netrw options
vim.g.netrw_list_hide = [[.aux$,.o$,.fdb_latexmk$,.fls$,.synctex.gz$]]

-- Performance options
set.confirm = true
set.autoread = true
set.lazyredraw = false
vim.o.updatetime = 200

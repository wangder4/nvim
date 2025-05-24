-- Bootstrap lazy.nvim
-- Trying to clone lazy.nvim if not already exists
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		lazyrepo,
		lazypath,
	})

	-- Error handling
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Setup lazy.nvim
local opts = {
	-- highlight-start
	spec = {
		-- import your plugins
		{ import = "plugins.tools" },
		{ import = "plugins.decoration" },
		-- { import = "plugins.tools.lsp" },
	},
	-- highlight-end

	-- Configuration
	-- *** color scheme that will be used when installing plugins/
	install = { colorscheme = { "habamax" } },
	-- *** automatically check for plugin updates
	checker = { enabled = false, notify = false },
	rocks = {
		enabled = false,
		hererocks = false,
	},
}

require("lazy").setup(opts)

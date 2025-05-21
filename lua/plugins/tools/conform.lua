-- conform.nvim  is a formatter plugin for nvim
-- This setup is inspired by https://www.josean.com/posts/neovim-linting-and-formatting
-- by josean
local function config()
	local conform = require("conform")
	local conform_opt = {
		notify_on_error = false,
		formatters_by_ft = {
			-- lua = { "stylua" },  -- 8 space tab, too ugly
			python = { "isort", "black" },
		},
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			if disable_filetypes[vim.bo[bufnr].filetype] then
				return nil
			else
				return { timeout_ms = 500, lsp_format = "fallback" }
			end
		end,
	}

	conform.setup(conform_opt)
	-- -- Using conform to set foldexpr
	-- vim.o.foldexpr = "v:lua.require'conform'.formatexpr()"
end

return {
	"stevearc/conform.nvim",
	-- event = { "BufReadPre", "BufNewFile" },
	config = config,
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
}

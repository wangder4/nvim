-- -- Lua does not recognize my files. Include it to access functions in utils.lua
package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/?.lua"
local utils = require("utils")

require("keymaps") -- Non-plugin mapping
require("options") -- Non-plugin options
require("clipboards") -- Setup clipboards, WSL or OSC 52

-- Load plugin-free autocmds
local autocmds_dir = "/lua/autocmds/"
utils.require_all_files_in_dir(autocmds_dir)

-- Temporarily disable providers, not used.
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

require("bootstrap") -- Lazy.vim startup, enable plugins
require("tunings") -- nvim options for plug-in co-operation

-- Setup cursor style, not working
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

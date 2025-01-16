-- Lua does not recognize my files. Include it to access functions in utils.lua
package.path = package.path .. ';' .. vim.fn.stdpath('config') .. '/?.lua'
local utils = require("utils")

require("keymaps")      -- Non-plugin mapping
require("clipboards")   -- Setup clipboards, WSL or OSC 52
require("options")      -- Non-plugin options

-- Load plugin-free autocmds
local autocmds_dir = '/lua/autocmds/'
utils.require_all_files_in_dir(autocmds_dir)

-- Setup providers executables explicitly if applicable
local wls_perl_host = '/usr/bin/perl'
local wls_python3_host = '/home/timachine/.pyvenv/311/bin/python3'
local wls_nodejs_host = '/home/timachine/.nvm/versions/node/v20.11.1/lib/node_modules/neovim/bin/cli.js'

local hosts = {
    perl_host_prog = wls_perl_host,
    python3_host_prog = wls_python3_host,
    node_host_prog = wls_nodejs_host
}

for host, host_path in pairs(hosts) do
    utils.set_host_prog(host, host_path)
end

require("bootstrap")    -- Lazy.vim startup, enable plugins
require("tunings")      -- nvim options for plug-in co-operation

-- Temporarily disable providers, not used.
vim.g.loaded_ruby_provider = 0

-- Setup cursor style, not working
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

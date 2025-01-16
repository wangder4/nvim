-- This module contains functions
local utils = {}

function utils.file_exists(path)
    local file = io.open(path, "rb")
    if file then
        file:close()
        return true
    else
        return false
    end
end

------------------------------------------------
function utils.require_all_files_in_dir(directory)
    -- Ensure the directory ends with a slash
    if not directory:match("/$") then
        directory = directory .. "/"
    end

    -- Read all the files in the directory
    local files = vim.fn.readdir(vim.fn.stdpath('config') .. directory)
    for _, file in ipairs(files) do
        if file:match("%.lua$") then
            -- forging module_name
            local module_name = (directory .. file:gsub("%.lua$", "")):gsub("/",".")
            require(module_name)
        end
    end
end


function utils.set_host_prog(host, host_path)
    if utils.file_exists(host_path) then
        vim.g[host] = host_path
    else
        print(host .. " is not set by init.lua")
    end
end

return utils

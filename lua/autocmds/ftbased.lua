-- Central configuration with defaults
local configs = {
    comments = {
        filetypes = { "systemverilog" }, -- Applies to all filetypes
        settings = {
            commentstring = {
                default = "// %s", -- Fallback default
            }
        }
    },

    indentation = {
        filetypes = { "*" },
        settings = {
            shiftwidth = {
                default = 4,
                tex = 2,
                lua = 2,
            },
            tabstop = {
                default = 4,
                tex = 2,
                lua = 2,
            },
            expandtab = {
                default = true,
            },
        }
    }
}

local function create_filetype_autocmd(config_group)
    local group = vim.api.nvim_create_augroup(config_group.name, { clear = true })

    return function(event, pattern, action)
        vim.api.nvim_create_autocmd(event, {
            group = group,
            pattern = pattern,
            callback = function(args)
                local ft = args.match
                if type(action) == "function" then
                    action(ft)
                elseif type(action) == "table" then
                    for setting, values in pairs(action) do
                        -- Use filetype-specific value or fallback to default
                        local value = values[ft] or values.default
                        if value ~= nil then
                            vim.bo[setting] = value
                        end
                    end
                end
            end
        })
    end
end

-- Initialize configuration factory
local setup = create_filetype_autocmd({ name = "FiletypeSettings" })

-- Apply configurations
for name, config in pairs(configs) do
    setup("FileType", config.filetypes, function(ft)
        for setting, values in pairs(config.settings) do
            local value = values[ft] or values.default
            if value ~= nil then
                vim.bo[setting] = value
            end
        end
    end)
end

-- Special case: Override defaults for specific filetypes
-- setup("FileType", {"markdown"}, function()
--   vim.bo.shiftwidth = 2
--   vim.bo.commentstring = "<!-- %s -->"
-- end)

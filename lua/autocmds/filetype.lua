-- This file sets the filetype of a file

-- Define shortcuts
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- Define augroup name and triggering events
local au_Filetype = create_augroup("Filetype", {clear = true})
local au_Filetype_events = {
    "BufRead", "BufNewFile",
}

-- Wrap filetype autocmd
local function set_filetype_for(pattern, filetype)
    create_autocmd(au_Filetype_events, {
        pattern = pattern,
        group = au_Filetype,
        callback = function()
            vim.api.nvim_command("set filetype=" .. filetype)
        end,
    })
end

-- Link event and triggers.
set_filetype_for("*.tex", "tex")

-- This file changes the g:conceallevel based on the current filetype.

-- Define shortcuts
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- Define filetype -> conceallevel relationships
local conceal_level_dict = {
    tex = 2
    -- Add additional filetypes and their respective conceal levels here
}

local function update_conceallevel()
    -- Set the conceal level based on the current buffer's filetype
    vim.opt_local.conceallevel = conceal_level_dict[vim.bo.filetype] or 0
end

-- Define augroup name and triggering events
local au_ConcealLevel = create_augroup("ConcealLevel", {clear=true})
local au_ConcealLevel_events = {
    "BufReadPost", "BufNewFile","BufEnter", "BufWinEnter",
}

-- Link event and triggers.
create_autocmd(au_ConcealLevel_events, {
    pattern = { "*" },
    group = au_ConcealLevel,
    callback = update_conceallevel,
})

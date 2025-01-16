-- Clipboards
-- ref: https://www.sxrhhh.top/blog/2024/06/06/neovim-copy-anywhere/#5-%E9%85%8D%E7%BD%AE-wsl
-- SSH solution by Sxrhhh
function my_paste(reg)
    -- This function returns '"' register's content.
    -- This is to avoid OSC 52 clipboard error when local terminal does not
    -- support OSC-52 to read from local clipboard.
    return function(lines)
        --[ 返回 “” 寄存器的内容，用来作为 p 操作符的粘贴物 ]
        local content = vim.fn.getreg('"')
        return vim.split(content, '\n')
    end
end

-- Setup
-- The below line is commented out, so that neovim won't overwrite system
-- clipboard by default
-- vim.opt.clipboard:append("unnamedplus")
if (os.getenv('SSH_TTY') == nil) then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
else
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ['+'] = my_paste("+"),
            ['*'] = my_paste("*"),
            -- ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            -- ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
        },
        cache_enabled = 0,
    }
end


local snippets = {}

local function in_mathzone()
    -- This function requires the VimTex plugin
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

table.insert(snippets, s({
    trig = "mm", desc = "Starts in-line math mode",
    snippetType = "autosnippet",
},
    fmta("$<>$", { i(1), })
))

table.insert(snippets, s({
    trig = "([%u%l])-([01])-(%l)", desc = "Mathmode serial sequence",
    snippetType = "autosnippet",
    condition = in_mathzone,
    regTrig = true,
    }, {
        f(function (_, snip)
            local letter = snip.captures[1]
            local startNum = tonumber(snip.captures[2])
            local closeLtr = snip.captures[3]
            local output = "%s_%d, %s_%d, \\dots, %s_%s"
            return string.format(output, letter, startNum, letter, startNum + 1, letter, closeLtr)
        end, {}),
    }
))

table.insert(snippets, s({
    trig = "([A-Za-z)]+)compl", desc = "Mathmode superscript complement symbol",
    snippetType = "autosnippet",
    condition = in_mathzone,
    regTrig = true,
    }, {
        f(function (_, snip)
            return snip.captures[1] .. "^\\complement"
        end, {}),
    }
))

return snippets

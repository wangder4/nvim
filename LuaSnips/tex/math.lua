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
    trig = "frac", desc = "fraction",
    snippetType = "autosnippet",
    condition = in_mathzone,
},
    fmta("\\frac{<>}{<>}", { i(1), i(2)})
))

table.insert(snippets, s({
    trig = "lim-", desc = "limit with no additionals",
    snippetType = "autosnippet",
    condition = in_mathzone,
},
    fmta("\\lim <>", { i(1), })
))

table.insert(snippets, s({
    trig = "lim_", desc = "limit with lower scores",
    snippetType = "autosnippet",
    condition = in_mathzone,
},
    fmta("\\lim_{<>}", { i(1), })
))

table.insert(snippets, s({
    trig = "lim([%u%l])", desc = "limit with X to infinity",
    snippetType = "autosnippet",
    condition = in_mathzone,
    regTrig = true,
    }, {
        f(function (_, snip)
            return string.format("\\lim_{%s \\to \\infty}", snip.captures[1])
        end, {}),
    }
))

table.insert(snippets, s({
    trig = "int([-=%w])([-=%w])", desc = "integral flexible",
    snippetType = "autosnippet",
    condition = in_mathzone,
    regTrig = true,
    }, {
        f(function (_, snip)
            local opt1 = snip.captures[1]
            local opt2 = snip.captures[2]
            local output = "\\int"
            if (not(opt1 == '-')) then
                if (opt1 == '=') then
                    output = output .. "_{-\\infty}"
                else
                    output = output .. string.format("_{%s}", opt1)
                end
            end

            if (not(opt2 == '-')) then
                if (opt2 == '=') then
                    output = output .. "^{+\\infty}"
                else
                    output = output .. string.format("^{%s}", opt2)
                end
            end
            return output
        end, {}),
    }
))

table.insert(snippets, s({
    trig = "([%u%l])-([01])-([%u%l])", desc = "Mathmode serial sequence",
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

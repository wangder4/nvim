local snippets = {}

local function in_mathzone()
    -- This function requires the VimTex plugin
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

table.insert(snippets, s({
        trig = "mm",
        desc = "Starts in-line math mode",
        snippetType = "autosnippet",
    },
    fmta("$<>$", { i(1), })
))

table.insert(snippets, s({
        trig = "frac",
        desc = "fraction",
        snippetType = "autosnippet",
        condition = in_mathzone,
    },
    fmta("\\frac{<>}{<>}", { i(1), i(2) })
))

table.insert(snippets, s({
        trig = "lim-",
        desc = "limit with no additionals",
        snippetType = "autosnippet",
        condition = in_mathzone,
    },
    fmta("\\lim <>", { i(1), })
))

table.insert(snippets, s({
        trig = "lim_",
        desc = "limit with lower scores",
        snippetType = "autosnippet",
        condition = in_mathzone,
    },
    fmta("\\lim_{<>}", { i(1), })
))

table.insert(snippets, s({
    trig = "limf/([^%s]+)",
    desc = "limit with X to infinity",
    snippetType = "autosnippet",
    condition = in_mathzone,
    regTrig = true,
}, {
    f(function(_, snip)
        return string.format("\\lim_{%s \\to \\infty}", snip.captures[1])
    end, {}),
}
))

table.insert(snippets, s({
    trig = "/(%w+)/([^/%s]+)/([^/%s]+)/([^%s]+)",
    desc = "common symbol snippets, comma means empty",
    snippetType = "snippet",
    condition = in_mathzone,
    regTrig = true,
}, {
    f(function(_, snip)
        local notion = snip.captures[1]
        local start = snip.captures[2]
        local finish = snip.captures[3]
        local symbol = snip.captures[4]
        local output = ""

        local function split_string_by_paren(s)
            local prefix, paren_part = s:match("^(.-)(%b())$")
            if prefix then
                return prefix, paren_part
            end

            prefix, paren_part = s:match("^(.-)(%b[])$")
            if prefix then
                return prefix, paren_part
            end

            return s, nil
        end

        if (notion == 'seq') then
            local symbol_prefix, symbol_postfix = split_string_by_paren(symbol)
            if (symbol_postfix) then
                output = "%s_{%d}%s, %s_{%d}%s, \\dots, %s_{%s}%s"
                return string.format(output,
                    symbol_prefix, start, symbol_postfix,
                    symbol_prefix, start + 1, symbol_postfix,
                    symbol_prefix, finish, symbol_postfix)
            else
                output = "%s_{%d}, %s_{%d}, \\dots, %s_{%s}"
                return string.format(output,
                    symbol, start, symbol, start + 1, symbol, finish)
            end
        end

        if (notion == 'sum') then
            output = output .. '\\sum'

            if (start == '=') then
                if (symbol == ',') then
                    output = output .. "_{-\\infty}"
                else
                    output = output .. string.format("_{%s = -\\infty}", symbol)
                end
            else
                if (symbol == ',') then
                    output = output .. string.format("_{%s}", start)
                else
                    output = output .. string.format("_{%s = %s}", symbol, start)
                end
            end

            if (finish == '=') then
                output = output .. "^{\\infty}"
            elseif (finish == ',') then
            else
                output = output .. string.format("^{%s}", finish)
            end

            return output
        end

        if (notion == 'prod') then
            output = output .. '\\prod'

            if (start == '=') then
                if (symbol == ',') then
                    output = output .. "_{-\\infty}"
                else
                    output = output .. string.format("_{%s = -\\infty}", symbol)
                end
            else
                if (symbol == ',') then
                    output = output .. string.format("_{%s}", start)
                else
                    output = output .. string.format("_{%s = %s}", symbol, start)
                end
            end

            if (finish == '=') then
                output = output .. "^{\\infty}"
            elseif (finish == ',') then
            else
                output = output .. string.format("^{%s}", finish)
            end

            return output
        end

        if (notion == 'bigcup') then
            output = output .. '\\bigcup'

            if (start == '=') then
                if (symbol == ',') then
                    output = output .. "_{%s = -\\infty}"
                else
                    output = output .. string.format("_{%s = -\\infty}", symbol)
                end
            else
                if (symbol == ',') then
                    output = output .. string.format("_{%s}", start)
                else
                    output = output .. string.format("_{%s = %s}", symbol, start)
                end
            end

            if (finish == '=') then
                output = output .. "^{\\infty}"
            elseif (finish == ',') then
            else
                output = output .. string.format("^{%s}", finish)
            end

            return output
        end

        if (notion == 'bigcap') then
            output = output .. '\\bigcap'

            if (start == '=') then
                if (symbol == ',') then
                    output = output .. "_{%s = -\\infty}"
                else
                    output = output .. string.format("_{%s = -\\infty}", symbol)
                end
            else
                if (symbol == ',') then
                    output = output .. string.format("_{%s}", symbol, start)
                else
                    output = output .. string.format("_{%s = %s}", symbol, start)
                end
            end

            if (finish == '=') then
                output = output .. "^{\\infty}"
            elseif (finish == ',') then
            else
                output = output .. string.format("^{%s}", finish)
            end

            return output
        end

        if (notion == 'int') then
            output = output .. '\\int'

            if (start == '=') then
                if (symbol == ',') then
                    output = output .. "_{-\\infty}"
                else
                    output = output .. string.format("_{-\\infty, %s}", symbol)
                end
            else
                if (symbol == ',') then
                    output = output .. string.format("_{%s}", start)
                else
                    output = output .. string.format("_{%s, %s}", start, symbol)
                end
            end

            if (finish == '=') then
                output = output .. "^{+\\infty}"
            elseif (finish == ',') then
            else
                output = output .. string.format("^{%s}", finish)
            end

            return output
        end

        if (notion == 'oint') then
            output = output .. '\\oint'

            if (start == '=') then
                if (symbol == ',') then
                    output = output .. "_{-\\infty}"
                else
                    output = output .. string.format("_{-\\infty, %s}", symbol)
                end
            else
                if (symbol == ',') then
                    output = output .. string.format("_{%s}", start)
                else
                    output = output .. string.format("_{%s, %s}", start, symbol)
                end
            end

            if (finish == '=') then
                output = output .. "^{+\\infty}"
            elseif (finish == ',') then
            else
                output = output .. string.format("^{%s}", finish)
            end

            return output
        end

        return string.format("/%s/%s/%s/%s", notion, start, finish, symbol)
    end, {}),
}
))

return snippets

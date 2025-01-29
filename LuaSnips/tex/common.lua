local snippets = {}

local env_shortcuts = {
    -- Rule of the shortcuts:
    -- 1. len(LHS) <= 3
    -- 2. len(RHS) >= 4
    al = "align",
    cor = "corollary",
    def = "definition",
    des = "description",
    doc = "document",
    eg = "example",
    enu = "enumerate",
    eq = "equation",
    exe = "exercise",
    exp = "explanation",
    it = "itemize",
    lem = "lemma",
    nt = "note",
    obs = "observe",
    prf = "proof",
    prb = "problem",
    prs = "proposition",
    prt = "property",
    rm = "remark",
    sol = "solution",
    tab = "tabular",
    tbl = "table",
    thm = "theorem",
}

table.insert(snippets, s(
{
    trig = "beg", desc = "LaTeX environment delimiters",
    snippetType = "autosnippet",
    condition = conds.line_begin,
},
    fmta([[
    \begin{<>}<>
    <>
    \end{<>}
    ]], { i(1), i(2), i(3), rep(1), })
))

table.insert(snippets, s(
{
    trig = "sec", desc = "LaTeX section",
    snippetType = "snippet",
    condition = conds.line_begin,
},
    fmta([[
    \section{<>}
    ]], { i(1), })
))

table.insert(snippets, s(
{
    trig = "#", desc = "LaTeX section",
    snippetType = "snippet",
    condition = conds.line_begin,
},
    fmta([[
    \section{<>}
    ]], { i(1), })
))

table.insert(snippets, s({
    trig = "ssec", desc = "LaTeX subsection",
    snippetType = "snippet",
    condition = conds.line_begin,
},
    fmta([[
    \subsection{<>}
    ]], { i(1), })
    ))

table.insert(snippets, s({
    trig = "##", desc = "LaTeX subsection",
    snippetType = "snippet",
    condition = conds.line_begin,
},
    fmta([[
    \subsection{<>}
    ]], { i(1), })
    ))

table.insert(snippets, s({
    trig = "(%w%w%w?)", desc = "expand env shortcuts",
    regTrig = true,
    -- trigEngine = "pattern",
    condition = function (line_to_cursor, _)
        return line_to_cursor:match("^%s*\\begin{")
    end,
    priority = 2000,     -- higher priority to ensure it won't affect beg
    },{
        f(function (_, snip)
            return env_shortcuts[snip.captures[1]] or snip.captures[1]
        end, {})
    }
))

return snippets

local snippets = {}

table.insert(snippets, s(
{
    trig = "temp_sub", desc = "Subfile document template",
    snippetType = "snippet",
    condition = conds.line_begin,
},
    fmta([[
    \documentclass[<>/master.tex]{subfiles}
    \begin{document}

    <>

    \end{document}
    ]], { i(1), i(2)})
))

return snippets

local M = {}

table.insert(M, s(
{
    trig = "int main", desc = "Main function",
    snippetType = "autosnippet",
    condition = conds.line_begin,
},
    fmta([[
    int main(int argc, char **argv) {
        <>
        return 0;
    }
    ]], {i(1)})
))

return M

local M = {}
table.insert(M, s(
{
    trig = "always_ff", desc = "SV always_ff",
    snippetType = "autosnippet",
    condition = conds.line_begin,
},
    fmta([[
    always_ff @ (posedge clk, negedge n_rst) begin: <>
    if (!n_rst)
        <>
    else
        <>
    end
    ]], {i(1), i(2), i(3)})
))

table.insert(M, s(
{
    trig = "always_comb", desc = "SV always_comb",
    snippetType = "autosnippet",
    condition = conds.line_begin,
},
    fmta([[
    always_comb begin: <>
        <>
    end 
    ]], {i(1), i(2)})
))

return M

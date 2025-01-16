--[[ 
The VimTex plugin utilize 'conceallevel' to transfer some of the commands.
However, the conceallevel is a windows-option. Therefore, the following code
changes the conceallevel for the current focus buffer.
--]]
vim.wo.concealcursor = "c"
-- vim.g.tex_conceal = "admgs"      -- VimTex does not respect this variable

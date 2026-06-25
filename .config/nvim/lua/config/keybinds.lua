local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<C-s>", ":w<CR>")
map("n", "<C-q>", ":q<CR>")
map("n", "<leader>fmt", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

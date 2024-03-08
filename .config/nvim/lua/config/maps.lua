vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0

vim.keymap.set("n", "<leader>fd", vim.cmd.Ex, { desc = "Explore directory of current file" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left windown" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right windown" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower windown" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper windown" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float, { desc = "Open diagnostic quickfix list" })

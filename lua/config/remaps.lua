-- TIP: Disable arrow keys in normal mode

vim.keymap.set("n", "<up>", '<cmd>echo " nope... k to move  ↑ "<CR>')
vim.keymap.set("n", "<left>", '<cmd>echo " nope... h to move ← "<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo " nope... l to move → "<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo " nope... j to move ↓ "<CR>')

-- open file tree
vim.keymap.set("n", "<C-e>", vim.cmd.Ex)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<A-C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<A-C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<A-C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<A-C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- move lines when highlighted and indent
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- jumping half page keeping cursor in the middle
vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "<C-u>zz")

-- serach cursor stays in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy paste
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Replace all - word that you are currently on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Forward incremental replace - word that you are currently on (one at a time)
-- period "." to repeat action
vim.keymap.set("n", "<leader>sf", "*``cgn")

-- Backward incremental replace - word that you are currently on (one at a time)
-- period "." to repeat action
vim.keymap.set("n", "<leader>sb", "#``cgN")

-- Visual mode partial word selection (one at a time)
-- period "." to repeat action
-- map same as forward inc. replace as action is the same
vim.keymap.set("x", "<leader>sf", [[y/\V<C-R>=escape(@",'/\')<CR><CR>Ncgn]])
-- lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
-- To jump back, press <C-t>.
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "[G]oto [D]efinition" })
-- Find references for the word under your cursor.
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "[G]oto [R]eferences" })
-- Fuzzy find all the symbols in your current document.
vim.keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "[D]ocument [S]ymbols" })

-- refactor
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- keep tabbing (v mode)
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- open issue preview
vim.keymap.set("n", "<leader>x", ":lua vim.diagnostic.open_float()<CR>")

-- go to next diagnostic error
vim.keymap.set("n", "nd", vim.diagnostic.goto_next)
-- vim.keymap.set("n", "nnd", vim.diagnostic.goto_prev)
